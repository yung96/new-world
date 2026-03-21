"""
Step recommend: every ~4km along the route, scan for POIs in our DB + 2GIS.
Attach food/stay/fuel/interest recommendations to each main stop.
"""

from __future__ import annotations

import asyncio
import json
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.post import Post
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import haversine, nearest_n, INTEREST_QUERIES
from app.services.travel_service import TravelService


SCAN_INTERVAL_KM = 4
SCAN_RADIUS_M = 2000  # 2km radius for 2GIS search


def _build_waypoints(coords: list[tuple[float, float]], interval_km: float) -> list[tuple[float, float]]:
    """Generate intermediate points every interval_km along the polyline."""
    if len(coords) < 2:
        return list(coords)

    waypoints = [coords[0]]
    accumulated = 0.0

    for i in range(1, len(coords)):
        d = haversine(coords[i - 1][0], coords[i - 1][1], coords[i][0], coords[i][1])
        accumulated += d
        if accumulated >= interval_km:
            waypoints.append(coords[i])
            accumulated = 0.0

    # Always include last point
    if coords[-1] != waypoints[-1]:
        waypoints.append(coords[-1])

    return waypoints


async def _search_2gis(travel: TravelService, lat: float, lng: float, queries: list[str], limit: int = 3) -> list[dict]:
    """Search 2GIS for POIs near a point."""
    results = []
    for query in queries:
        try:
            pois = await travel.dgis_search(query=query, lat=lat, lon=lng, radius_m=SCAN_RADIUS_M, limit=limit)
            for poi in pois:
                results.append({
                    "name": poi.get("name", ""),
                    "address": poi.get("address", ""),
                    "type": query,
                    "source": "2gis",
                    "lat": lat,
                    "lng": lng,
                })
            await asyncio.sleep(0.3)  # rate limit
        except Exception as e:
            logger.debug("[recommend] 2gis search failed for '{}': {}", query, e)
    return results


async def step_recommend(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        # Load main experiences
        items = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(RouteSegment.route_id == route_id, SegmentItem.type == "experience", SegmentItem.parent_id.isnot(None))
            .order_by(RouteSegment.position, SegmentItem.position)
        )).scalars().all()

        if not items:
            return

        # Collect route coords
        coords = []
        for item in items:
            d = json.loads(item.details or "{}")
            lat, lng = d.get("lat", 0), d.get("lng", 0)
            if lat and lng:
                coords.append((lat, lng))

        # Build scan waypoints every 4km
        waypoints = _build_waypoints(coords, SCAN_INTERVAL_KM)
        logger.info("[recommend] {} waypoints (every {}km) for {} route points", len(waypoints), SCAN_INTERVAL_KM, len(items))

        # Load our DB posts for local matching
        food_posts = (await db.execute(
            select(Post).where(Post.description.in_(["Ресторан", "Кафе"]), Post.geo_lat.isnot(None))
        )).scalars().all()

        stay_posts = (await db.execute(
            select(Post).where(Post.description.in_(["Гостиница", "Кемпинг / Глэмпинг"]), Post.geo_lat.isnot(None))
        )).scalars().all()

        fuel_posts = (await db.execute(
            select(Post).where(Post.description == "Автозаправочная станция", Post.geo_lat.isnot(None))
        )).scalars().all() if params.get("transport") == "car" else []

        # Build 2GIS search queries from interests
        interests = params.get("interests", [])
        dgis_queries = ["кафе", "ресторан"]  # always search food
        for interest in interests:
            dgis_queries.extend(INTEREST_QUERIES.get(interest, []))
        dgis_queries = list(dict.fromkeys(dgis_queries))  # dedupe

        travel = TravelService()
        rec_pos = 1000

        # For each main stop: scan DB + 2GIS
        for item in items:
            d = json.loads(item.details or "{}")
            lat, lng = d.get("lat", 0), d.get("lng", 0)
            if not lat or not lng:
                continue

            seg_id = item.segment_id

            # --- DB: nearest food ---
            db_food = nearest_n(lat, lng, food_posts, 3, max_km=5)
            food_options = [
                {"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                 "lat": fp.geo_lat, "lng": fp.geo_lng, "type": fp.description, "source": "db"}
                for fp, dist in db_food
            ]

            # --- 2GIS: food + interest POIs ---
            try:
                dgis_pois = await _search_2gis(travel, lat, lng, dgis_queries[:4], limit=2)
                # Merge with DB results, avoid dupes by name
                known_names = {opt["name"].lower() for opt in food_options}
                for poi in dgis_pois:
                    if poi["name"].lower() not in known_names:
                        food_options.append(poi)
                        known_names.add(poi["name"].lower())
            except Exception as e:
                logger.debug("[recommend] 2gis scan failed: {}", e)

            if food_options:
                db.add(SegmentItem(
                    segment_id=seg_id, parent_id=item.id, type="experience", position=rec_pos,
                    details=json.dumps({"recommendation_type": "food", "options": food_options[:5]}),
                ))
                rec_pos += 1

            # --- DB: nearest fuel (if car) ---
            if fuel_posts:
                db_fuel = nearest_n(lat, lng, fuel_posts, 2, max_km=10)
                if db_fuel:
                    fuel_options = [
                        {"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                         "lat": fp.geo_lat, "lng": fp.geo_lng, "source": "db"}
                        for fp, dist in db_fuel
                    ]
                    db.add(SegmentItem(
                        segment_id=seg_id, parent_id=item.id, type="experience", position=rec_pos,
                        details=json.dumps({"recommendation_type": "fuel", "options": fuel_options}),
                    ))
                    rec_pos += 1

        # --- Stays: per segment (per day) ---
        segments = (await db.execute(
            select(RouteSegment).where(RouteSegment.route_id == route_id).order_by(RouteSegment.position)
        )).scalars().all()

        total_stays = 0
        for seg in segments:
            seg_items = [it for it in items if it.segment_id == seg.id]
            if not seg_items:
                continue
            first_d = json.loads(seg_items[0].details or "{}")
            lat, lng = first_d.get("lat", 0), first_d.get("lng", 0)

            db_stays = nearest_n(lat, lng, stay_posts, 3, max_km=30)

            # Also try 2GIS for hotels
            dgis_stays = []
            try:
                dgis_stays = await _search_2gis(travel, lat, lng, ["гостиница", "отель"], limit=2)
            except Exception:
                pass

            stay_options = [
                {"name": sp.title, "post_id": sp.id, "distance_km": round(dist, 1),
                 "lat": sp.geo_lat, "lng": sp.geo_lng, "type": sp.description, "source": "db"}
                for sp, dist in db_stays
            ]
            known = {opt["name"].lower() for opt in stay_options}
            for poi in dgis_stays:
                if poi["name"].lower() not in known:
                    stay_options.append(poi)

            if stay_options:
                db.add(SegmentItem(
                    segment_id=seg.id, parent_id=None, type="stay", position=rec_pos,
                    details=json.dumps({"recommendation_type": "stay", "options": stay_options[:4]}),
                ))
                rec_pos += 1
                total_stays += len(stay_options[:4])

        # Update counters
        route = await db.get(Route, route_id)
        if route:
            route.total_hotels = total_stays
            if params.get("transport") == "car":
                route.total_transports = 1

        await db.commit()
        logger.info("[pipeline] recommend: {} waypoints scanned, route {}", len(waypoints), route_id)
