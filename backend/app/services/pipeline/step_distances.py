from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import haversine
from app.services.travel_service import TravelService


TRANSPORT_MAP = {
    "car": "driving",
    "public": "public_transport",
    "none": "walking",
}


async def _real_distances(coords: list[tuple[float, float]], transport: str) -> list[dict] | None:
    """Try 2GIS matrix API. Returns list of {distance_m, duration_s} or None on failure."""
    if len(coords) < 2:
        return None

    travel = TravelService()
    points = [{"lat": lat, "lon": lng} for lat, lng in coords]

    # Build source→target pairs (consecutive)
    sources = list(range(len(coords) - 1))
    targets = list(range(1, len(coords)))

    body = {
        "points": points,
        "sources": sources,
        "targets": targets,
        "transport": TRANSPORT_MAP.get(transport, "driving"),
    }

    try:
        result = await travel.get_route_matrix_info(body)
        routes = result.get("routes", [])
        if not routes:
            return None

        pairs = []
        for r in routes:
            pairs.append({
                "distance_m": r.get("distance", 0),
                "duration_s": r.get("duration", 0),
            })
        return pairs
    except Exception as e:
        logger.warning("[pipeline] 2GIS distance failed, falling back to haversine: {}", e)
        return None


async def step_distances(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        items = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(
                RouteSegment.route_id == route_id,
                SegmentItem.type == "experience",
                SegmentItem.parent_id.isnot(None),
            )
            .order_by(RouteSegment.position, SegmentItem.position)
        )).scalars().all()

        if len(items) < 2:
            return

        transport = params.get("transport", "car")

        # Collect coords
        coords = []
        for item in items:
            d = json.loads(item.details or "{}")
            coords.append((d.get("lat", 0), d.get("lng", 0)))

        # Try real routing via 2GIS
        real = await _real_distances(coords, transport)

        total_km = 0
        for i in range(len(items) - 1):
            d1 = json.loads(items[i].details or "{}")

            if real and i < len(real):
                dist_km = real[i]["distance_m"] / 1000
                dur_min = real[i]["duration_s"] / 60
                source = "2gis"
            else:
                # Fallback to haversine
                d2 = json.loads(items[i + 1].details or "{}")
                dist_km = haversine(d1.get("lat", 0), d1.get("lng", 0), d2.get("lat", 0), d2.get("lng", 0))
                speed = 60 if transport == "car" else 15
                dur_min = dist_km / speed * 60
                source = "haversine"

            total_km += dist_km
            d1["distance_to_next_km"] = round(dist_km, 1)
            d1["duration_to_next_min"] = round(dur_min)
            d1["transport_to_next"] = transport
            d1["distance_source"] = source
            items[i].details = json.dumps(d1)

        route = await db.get(Route, route_id)
        if route and route.params:
            p = dict(route.params)
            p["total_km"] = round(total_km, 1)
            route.params = p

        await db.commit()
        src = "2gis" if real else "haversine"
        logger.info("[pipeline] distances: {:.0f}km ({}) for route {}", total_km, src, route_id)
