from __future__ import annotations

import json
from datetime import timedelta
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import parse_date
from app.services.travel_service import TravelService


async def step_weather(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        item = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(RouteSegment.route_id == route_id, SegmentItem.type == "experience", SegmentItem.parent_id.isnot(None))
            .order_by(RouteSegment.position, SegmentItem.position).limit(1)
        )).scalars().first()

        if not item:
            return

        d = json.loads(item.details or "{}")
        lat, lng = d.get("lat"), d.get("lng")
        if not lat or not lng:
            return

        try:
            travel = TravelService()
            weather = await travel.get_weather_info(lat, lng)

            route = await db.get(Route, route_id)
            if route and route.params:
                p = dict(route.params)
                p["weather"] = weather

                d_from = parse_date(params.get("dateFrom"))
                d_to = parse_date(params.get("dateTo"))
                if d_from and d_to:
                    days = (d_to - d_from).days + 1
                    p["weatherPerDay"] = [
                        {"date": str(d_from + timedelta(days=i)),
                         "tempC": weather.get("temperature"),
                         "weather": weather.get("weather"),
                         "icon": weather.get("weathercode")}
                        for i in range(days)
                    ]

                route.params = p
                await db.commit()
        except Exception as e:
            logger.warning("[pipeline] weather failed: {}", e)

        logger.info("[pipeline] weather: route {}", route_id)
