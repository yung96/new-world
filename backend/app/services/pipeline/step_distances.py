from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import haversine


async def step_distances(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        # Get all experiences (they now live inside days via parent_id)
        items = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(
                RouteSegment.route_id == route_id,
                SegmentItem.type == "experience",
                SegmentItem.parent_id.isnot(None),  # inside a day
            )
            .order_by(RouteSegment.position, SegmentItem.position)
        )).scalars().all()

        if len(items) < 2:
            return

        total_km = 0
        transport = params.get("transport", "car")
        speed = 60 if transport == "car" else 15

        for i in range(len(items) - 1):
            d1 = json.loads(items[i].details or "{}")
            d2 = json.loads(items[i + 1].details or "{}")
            dist = haversine(d1.get("lat", 0), d1.get("lng", 0), d2.get("lat", 0), d2.get("lng", 0))
            total_km += dist

            d1["distance_to_next_km"] = round(dist, 1)
            d1["duration_to_next_min"] = round(dist / speed * 60)
            d1["transport_to_next"] = transport
            items[i].details = json.dumps(d1)

        route = await db.get(Route, route_id)
        if route and route.params:
            p = dict(route.params)
            p["total_km"] = round(total_km, 1)
            route.params = p

        await db.commit()
        logger.info("[pipeline] distances: {:.0f}km for route {}", total_km, route_id)
