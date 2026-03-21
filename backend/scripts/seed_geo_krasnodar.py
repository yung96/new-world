#!/usr/bin/env python3
"""
Seed script: geo regions + POIs for Краснодарский край from OpenStreetMap Overpass API.

Usage (from backend/ directory or anywhere):
    python scripts/seed_geo_krasnodar.py

What it does:
  Part 1 — Geo hierarchy:
    Russia (hardcoded country) → Краснодарский край (region) →
    Districts / районы (admin_level=6) → Cities / towns (admin_level=8)

  Part 2 — POIs as Posts:
    restaurants, cafes, fuel stations, hotels, attractions, museums
    inside the Krasnodar Krai bounding box

Idempotent: skips insert if "Краснодарский край" already exists.
"""

from __future__ import annotations

import json
import math
import os
import sys
import time

# ---------------------------------------------------------------------------
# Path + env setup — must happen before any app import
# ---------------------------------------------------------------------------
_BACKEND_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if _BACKEND_DIR not in sys.path:
    sys.path.insert(0, _BACKEND_DIR)

os.environ.setdefault(
    "DATABASE_URL",
    "postgresql+asyncpg://kraeved_user:kraeved_password@localhost:15432/kraeved",
)
os.environ.setdefault("SECRET_KEY", "seed")
os.environ.setdefault("TRAVEL_API_KEY", "x")
os.environ.setdefault("TGIS_API_KEY", "x")
os.environ.setdefault("DADATA_API_KEY", "x")

import requests
from sqlalchemy import create_engine, text
from sqlalchemy.orm import Session

from app.models.geo import GeoRegion, GeoRegionType
from app.models.post import Post, Season
from app.models.user import User, UserRole

# ---------------------------------------------------------------------------
# DB engine (sync psycopg2 for seeding)
# ---------------------------------------------------------------------------
SYNC_DB_URL = "postgresql+psycopg2://kraeved_user:kraeved_password@localhost:15432/kraeved"
engine = create_engine(SYNC_DB_URL, pool_pre_ping=True)

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
OVERPASS_URL = "https://overpass-api.de/api/interpreter"
OVERPASS_TIMEOUT = 60  # seconds per request
REQUEST_PAUSE = 2       # seconds between Overpass calls

# Krasnodar Krai bounding box (south, west, north, east)
KK_BBOX = "43.5,36.5,46.5,41.5"

SYSTEM_USER_PHONE = "+70000000000"

# ---------------------------------------------------------------------------
# Transliteration table (Russian → latin for slug)
# ---------------------------------------------------------------------------
_TRANSLIT = {
    "а": "a", "б": "b", "в": "v", "г": "g", "д": "d",
    "е": "e", "ё": "yo", "ж": "zh", "з": "z", "и": "i",
    "й": "y", "к": "k", "л": "l", "м": "m", "н": "n",
    "о": "o", "п": "p", "р": "r", "с": "s", "т": "t",
    "у": "u", "ф": "f", "х": "kh", "ц": "ts", "ч": "ch",
    "ш": "sh", "щ": "shch", "ъ": "", "ы": "y", "ь": "",
    "э": "e", "ю": "yu", "я": "ya",
    # uppercase handled via lower() before lookup
}


def slugify(text: str) -> str:
    """Transliterate a Russian string and turn it into a URL-safe slug."""
    result = []
    for ch in text.lower():
        result.append(_TRANSLIT.get(ch, ch))
    slug = "".join(result)
    # Replace any non-alphanumeric characters with a hyphen
    import re
    slug = re.sub(r"[^a-z0-9]+", "-", slug)
    slug = slug.strip("-")
    return slug


# ---------------------------------------------------------------------------
# POI category descriptions in Russian
# ---------------------------------------------------------------------------
POI_DESCRIPTIONS: dict[str, str] = {
    "restaurant": "Ресторан",
    "cafe": "Кафе",
    "fuel": "Автозаправочная станция",
    "hotel": "Гостиница",
    "attraction": "Достопримечательность",
    "museum": "Музей",
}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def overpass_query(ql: str) -> dict:
    """POST a query to Overpass API and return parsed JSON."""
    print(f"  [Overpass] sending query ({len(ql)} chars)…")
    resp = requests.post(
        OVERPASS_URL,
        data={"data": ql},
        timeout=OVERPASS_TIMEOUT,
    )
    resp.raise_for_status()
    return resp.json()


def extract_centroid(geometry: dict | None, elements: list[dict], element: dict) -> tuple[float, float] | None:
    """
    Derive a centroid (lat, lon) from:
      1. 'center' key on the element itself (Overpass out center)
      2. GeoJSON geometry (Point / Polygon / MultiPolygon)
      3. Node lat/lon directly
    """
    # Direct center from Overpass
    if "center" in element:
        c = element["center"]
        return float(c["lat"]), float(c["lon"])

    # Node with direct coords
    if element.get("type") == "node" and "lat" in element:
        return float(element["lat"]), float(element["lon"])

    # Geometry object
    if geometry:
        gtype = geometry.get("type", "")
        coords = geometry.get("coordinates")
        if gtype == "Point" and coords:
            return float(coords[1]), float(coords[0])
        if gtype == "Polygon" and coords:
            ring = coords[0]
            if ring:
                avg_lat = sum(p[1] for p in ring) / len(ring)
                avg_lon = sum(p[0] for p in ring) / len(ring)
                return avg_lat, avg_lon
        if gtype == "MultiPolygon" and coords:
            all_pts = [p for poly in coords for ring in poly for p in ring]
            if all_pts:
                avg_lat = sum(p[1] for p in all_pts) / len(all_pts)
                avg_lon = sum(p[0] for p in all_pts) / len(all_pts)
                return avg_lat, avg_lon

    return None


def haversine_km(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """Great-circle distance in km between two points."""
    R = 6371.0
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi = math.radians(lat2 - lat1)
    dlam = math.radians(lon2 - lon1)
    a = math.sin(dphi / 2) ** 2 + math.cos(phi1) * math.cos(phi2) * math.sin(dlam / 2) ** 2
    return R * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def find_nearest_region(lat: float, lon: float, candidates: list[GeoRegion]) -> GeoRegion | None:
    """Return the region whose centroid is closest to (lat, lon)."""
    best: GeoRegion | None = None
    best_dist = float("inf")
    for region in candidates:
        if not region.centroid:
            continue
        try:
            parts = region.centroid.split(",")
            r_lat, r_lon = float(parts[0]), float(parts[1])
        except Exception:
            continue
        d = haversine_km(lat, lon, r_lat, r_lon)
        if d < best_dist:
            best_dist = d
            best = region
    return best


def ensure_unique_slug(session: Session, base_slug: str) -> str:
    """Append a counter suffix until the slug is unique in geo_regions."""
    slug = base_slug
    counter = 1
    while session.query(GeoRegion).filter_by(slug=slug).first() is not None:
        slug = f"{base_slug}-{counter}"
        counter += 1
    return slug


def build_geojson_polygon(element: dict, nodes_index: dict) -> dict | None:
    """
    Reconstruct a GeoJSON polygon from a relation or way element
    returned by Overpass (geom or members).
    Returns a GeoJSON Geometry dict or None.
    """
    # If Overpass returned inline geometry
    if "geometry" in element:
        geom = element["geometry"]
        if isinstance(geom, list) and geom:
            # List of {lat, lon} — a way ring
            coords = [[p["lon"], p["lat"]] for p in geom]
            if coords[0] != coords[-1]:
                coords.append(coords[0])
            return {"type": "Polygon", "coordinates": [coords]}
        if isinstance(geom, dict):
            return geom

    # Relation with members
    if element.get("type") == "relation" and "members" in element:
        rings = []
        for member in element["members"]:
            if member.get("type") == "way" and "geometry" in member:
                pts = member["geometry"]
                ring = [[p["lon"], p["lat"]] for p in pts]
                if ring and ring[0] != ring[-1]:
                    ring.append(ring[0])
                rings.append(ring)
        if rings:
            return {"type": "MultiPolygon", "coordinates": [[r] for r in rings]}

    # Way with node references
    if element.get("type") == "way" and "nodes" in element:
        coords = []
        for nid in element["nodes"]:
            node = nodes_index.get(nid)
            if node:
                coords.append([node["lon"], node["lat"]])
        if coords:
            if coords[0] != coords[-1]:
                coords.append(coords[0])
            return {"type": "Polygon", "coordinates": [coords]}

    return None


# ---------------------------------------------------------------------------
# Part 1 — Geo regions
# ---------------------------------------------------------------------------

def fetch_krasnodar_krai() -> dict | None:
    """Fetch the Krasnodar Krai relation from Overpass."""
    ql = f"""
[out:json][timeout:{OVERPASS_TIMEOUT}];
relation["boundary"="administrative"]["admin_level"="4"]["name"="Краснодарский край"];
out geom;
"""
    data = overpass_query(ql)
    elements = data.get("elements", [])
    if not elements:
        print("  WARNING: Краснодарский край relation not found.")
        return None
    return elements[0]


def fetch_districts(krai_relation_id: int) -> list[dict]:
    """Fetch admin_level=6 relations (районы) inside Krasnodar Krai."""
    area_id = 3600000000 + krai_relation_id
    ql = f"""
[out:json][timeout:{OVERPASS_TIMEOUT}];
area({area_id})->.krai;
relation(area.krai)["boundary"="administrative"]["admin_level"="6"];
out center;
"""
    data = overpass_query(ql)
    return data.get("elements", [])


def fetch_cities(krai_relation_id: int) -> list[dict]:
    """Fetch admin_level=8 nodes/relations (cities/towns) inside Krasnodar Krai."""
    area_id = 3600000000 + krai_relation_id
    ql = f"""
[out:json][timeout:{OVERPASS_TIMEOUT}];
area({area_id})->.krai;
(
  node(area.krai)["place"~"^(city|town)$"];
  relation(area.krai)["place"~"^(city|town)$"];
);
out center;
"""
    data = overpass_query(ql)
    return data.get("elements", [])


def seed_geo_regions(session: Session) -> dict[str, GeoRegion]:
    """
    Seed Russia → Краснодарский край → Districts → Cities.
    Returns a dict slug→GeoRegion for all inserted/found regions.
    """
    print("\n=== Part 1: Geo regions ===")

    # ---- Russia (hardcoded) ----
    russia = session.query(GeoRegion).filter_by(slug="russia").first()
    if not russia:
        russia = GeoRegion(
            name="Россия",
            slug="russia",
            type=GeoRegionType.country,
            centroid="60.0,90.0",
        )
        session.add(russia)
        session.flush()
        print("  Inserted: Россия (country)")
    else:
        print("  Found existing: Россия")

    # ---- Краснодарский край ----
    krai_region = session.query(GeoRegion).filter_by(name="Краснодарский край").first()
    if krai_region:
        print("  Краснодарский край already exists — skipping geo seed (idempotent).")
        # Still build the lookup dict for Part 2
        all_regions: dict[str, GeoRegion] = {}
        for r in session.query(GeoRegion).all():
            all_regions[r.slug] = r
        return all_regions

    print("\n  Fetching Краснодарский край boundary…")
    krai_el = fetch_krasnodar_krai()
    time.sleep(REQUEST_PAUSE)

    krai_geojson = None
    krai_centroid = None
    krai_osm_id = None

    if krai_el:
        krai_osm_id = krai_el.get("id")
        krai_geojson = build_geojson_polygon(krai_el, {})
        centroid_coords = extract_centroid(krai_geojson, [], krai_el)
        if centroid_coords:
            krai_centroid = f"{centroid_coords[0]},{centroid_coords[1]}"
        tags = krai_el.get("tags", {})
        population_raw = tags.get("population")
        krai_population = None
        if population_raw:
            try:
                krai_population = int(population_raw.replace(" ", "").replace(",", ""))
            except ValueError:
                pass
    else:
        # Fallback values if Overpass fails
        krai_centroid = "45.0,39.0"
        krai_population = None

    krai_slug = "krasnodarskiy-kray"
    krai_region = GeoRegion(
        name="Краснодарский край",
        slug=krai_slug,
        type=GeoRegionType.region,
        parent_id=russia.id,
        centroid=krai_centroid,
        polygon=json.dumps(krai_geojson) if krai_geojson else None,
        population=krai_population,
        timezone="Europe/Moscow",
    )
    session.add(krai_region)
    session.flush()
    print(f"  Inserted: Краснодарский край (region, id={krai_region.id})")

    all_regions: dict[str, GeoRegion] = {"russia": russia, krai_slug: krai_region}

    # ---- Districts ----
    if krai_osm_id:
        print(f"\n  Fetching districts (admin_level=6) for OSM relation {krai_osm_id}…")
        try:
            district_elements = fetch_districts(krai_osm_id)
            time.sleep(REQUEST_PAUSE)
            print(f"  Found {len(district_elements)} district elements.")
        except Exception as exc:
            print(f"  ERROR fetching districts: {exc}")
            district_elements = []
    else:
        district_elements = []

    district_regions: list[GeoRegion] = []
    for el in district_elements:
        tags = el.get("tags", {})
        name = tags.get("name:ru") or tags.get("name")
        if not name:
            continue

        geojson = build_geojson_polygon(el, {})
        centroid_coords = extract_centroid(geojson, [], el)
        centroid_str = f"{centroid_coords[0]},{centroid_coords[1]}" if centroid_coords else None

        population_raw = tags.get("population")
        population = None
        if population_raw:
            try:
                population = int(population_raw.replace(" ", "").replace(",", ""))
            except ValueError:
                pass

        base_slug = slugify(name)
        slug = ensure_unique_slug(session, base_slug)

        district = GeoRegion(
            name=name,
            slug=slug,
            type=GeoRegionType.district,
            parent_id=krai_region.id,
            centroid=centroid_str,
            polygon=json.dumps(geojson) if geojson else None,
            population=population,
            timezone="Europe/Moscow",
        )
        session.add(district)
        session.flush()
        district_regions.append(district)
        all_regions[slug] = district
        print(f"    + district: {name} ({slug})")

    print(f"  Inserted {len(district_regions)} districts.")

    # ---- Cities ----
    if krai_osm_id:
        print(f"\n  Fetching cities/towns (admin_level=8) for OSM relation {krai_osm_id}…")
        try:
            city_elements = fetch_cities(krai_osm_id)
            time.sleep(REQUEST_PAUSE)
            print(f"  Found {len(city_elements)} city/town elements.")
        except Exception as exc:
            print(f"  ERROR fetching cities: {exc}")
            city_elements = []
    else:
        city_elements = []

    city_regions: list[GeoRegion] = []
    for el in city_elements:
        tags = el.get("tags", {})
        name = tags.get("name:ru") or tags.get("name")
        if not name:
            continue

        geojson = build_geojson_polygon(el, {})
        centroid_coords = extract_centroid(geojson, [], el)
        centroid_str = f"{centroid_coords[0]},{centroid_coords[1]}" if centroid_coords else None

        population_raw = tags.get("population")
        population = None
        if population_raw:
            try:
                population = int(population_raw.replace(" ", "").replace(",", ""))
            except ValueError:
                pass

        # Try to assign to nearest district as parent, fallback to krai
        parent_id = krai_region.id
        if centroid_coords and district_regions:
            nearest_district = find_nearest_region(
                centroid_coords[0], centroid_coords[1], district_regions
            )
            if nearest_district:
                parent_id = nearest_district.id

        base_slug = slugify(name)
        slug = ensure_unique_slug(session, base_slug)

        city = GeoRegion(
            name=name,
            slug=slug,
            type=GeoRegionType.city,
            parent_id=parent_id,
            centroid=centroid_str,
            polygon=json.dumps(geojson) if geojson else None,
            population=population,
            timezone="Europe/Moscow",
        )
        session.add(city)
        session.flush()
        city_regions.append(city)
        all_regions[slug] = city
        print(f"    + city: {name} ({slug})")

    session.commit()
    print(f"\n  Inserted {len(city_regions)} cities/towns.")
    print(f"  Total regions inserted: {2 + len(district_regions) + len(city_regions)}")

    return all_regions


# ---------------------------------------------------------------------------
# Part 2 — POIs as Posts
# ---------------------------------------------------------------------------

POI_QUERIES: list[tuple[str, str, int]] = [
    # (overpass_filter, category_key, limit)
    ('["amenity"="restaurant"]', "restaurant", 100),
    ('["amenity"="cafe"]',       "cafe",        100),
    ('["amenity"="fuel"]',       "fuel",         50),
    ('["tourism"="hotel"]',      "hotel",        50),
    ('["tourism"="attraction"]', "attraction",   50),
    ('["tourism"="museum"]',     "museum",       30),
]


def fetch_pois(overpass_filter: str, limit: int) -> list[dict]:
    """Fetch POI nodes/ways/relations within the Krasnodar Krai bounding box."""
    ql = f"""
[out:json][timeout:{OVERPASS_TIMEOUT}];
(
  node{overpass_filter}({KK_BBOX});
  way{overpass_filter}({KK_BBOX});
  relation{overpass_filter}({KK_BBOX});
);
out center {limit};
"""
    data = overpass_query(ql)
    return data.get("elements", [])


def ensure_system_user(session: Session) -> int:
    """Return the id=1 user or create a system user if none exists."""
    user = session.get(User, 1)
    if user:
        return user.id

    # Try to get any existing user
    first_user = session.query(User).first()
    if first_user:
        return first_user.id

    # Create a minimal system user
    system_user = User(
        phone=SYSTEM_USER_PHONE,
        name="Система",
        role=UserRole.tourist,
    )
    session.add(system_user)
    session.flush()
    print(f"  Created system user id={system_user.id}")
    return system_user.id


def seed_pois(session: Session, all_regions: dict[str, GeoRegion], author_id: int) -> None:
    """Fetch POIs from Overpass and insert as Posts."""
    print("\n=== Part 2: POIs as Posts ===")

    # Build flat list of city/district regions for proximity matching
    city_and_district_regions = [
        r for r in all_regions.values()
        if r.type in (GeoRegionType.city, GeoRegionType.district)
    ]

    # Fallback: use krai region itself
    krai_region = next(
        (r for r in all_regions.values() if r.type == GeoRegionType.region),
        None,
    )

    total_inserted = 0

    for overpass_filter, category_key, limit in POI_QUERIES:
        description_ru = POI_DESCRIPTIONS.get(category_key, category_key)
        print(f"\n  Fetching {description_ru} (limit {limit})…")

        try:
            elements = fetch_pois(overpass_filter, limit)
            time.sleep(REQUEST_PAUSE)
        except Exception as exc:
            print(f"  ERROR fetching {category_key}: {exc}")
            continue

        print(f"  Got {len(elements)} elements.")
        inserted = 0

        for el in elements:
            tags = el.get("tags", {})
            name = tags.get("name:ru") or tags.get("name")
            if not name:
                continue  # skip unnamed POIs

            # Extract coordinates
            centroid_coords = extract_centroid(None, [], el)
            if not centroid_coords:
                continue

            lat, lon = centroid_coords

            # Find nearest region
            region_id: int | None = None
            if city_and_district_regions:
                nearest = find_nearest_region(lat, lon, city_and_district_regions)
                if nearest:
                    region_id = nearest.id
            if region_id is None and krai_region:
                region_id = krai_region.id

            # Build address string from OSM tags when available
            addr_parts = []
            for tag in ("addr:street", "addr:housenumber", "addr:city"):
                val = tags.get(tag)
                if val:
                    addr_parts.append(val)
            address = ", ".join(addr_parts) if addr_parts else None

            post = Post(
                author_id=author_id,
                title=name,
                description=description_ru,
                geo_lat=lat,
                geo_lng=lon,
                season=Season.summer,
                region_id=region_id,
                address=address,
                phone=tags.get("phone") or tags.get("contact:phone"),
                website=tags.get("website") or tags.get("contact:website"),
                verified=False,
            )
            session.add(post)
            inserted += 1

        session.commit()
        total_inserted += inserted
        print(f"  Inserted {inserted} {description_ru} posts.")

    print(f"\n  Total POI posts inserted: {total_inserted}")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    print("=" * 60)
    print("  Seed: Краснодарский край geo + POIs")
    print("=" * 60)

    with Session(engine) as session:
        # ---- System user ----
        author_id = ensure_system_user(session)
        session.commit()
        print(f"  Using author_id={author_id} for POI posts.")

        # ---- Part 1 ----
        all_regions = seed_geo_regions(session)

        # ---- Part 2 ----
        seed_pois(session, all_regions, author_id)

    print("\nDone.")


if __name__ == "__main__":
    main()
