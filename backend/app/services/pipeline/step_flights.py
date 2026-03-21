from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select
from app.db import async_session_factory
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.travel_service import TravelService


async def step_flights(route_id: int, params: dict[str, Any]) -> None:
    transport = params.get("transport")
    date_from = params.get("dateFrom")

    if transport == "none" or not date_from:
        logger.info("[pipeline] flights: skipped")
        return

    travel = TravelService()

    async with async_session_factory() as db:
        route = await db.get(Route, route_id)
        if not route:
            return

        seg = (
            await db.execute(
                select(RouteSegment).where(RouteSegment.route_id == route_id).limit(1)
            )
        ).scalar_one_or_none()
        if not seg:
            return

        try:
            flight_data = await travel.get_global_route(
                {
                    "origin": "Москва",
                    "destination": "Краснодар",
                    "departure_at": str(date_from)[:7],
                    "one_way": True,
                    "limit": 3,
                    "sorting": "price",
                    "currency": "rub",
                    "market": "ru",
                }
            )

            tickets = flight_data.get("data", [])
            for i, ticket in enumerate(tickets[:3]):
                db.add(
                    SegmentItem(
                        segment_id=seg.id,
                        type="leg",
                        position=-(3 - i),
                        price=ticket.get("price"),
                        price_currency="RUB",
                        provider_name=ticket.get("airline", ""),
                        provider_url=f"https://www.aviasales.ru{ticket.get('link', '')}",
                        details=json.dumps(
                            {
                                "from": ticket.get("origin", ""),
                                "to": ticket.get("destination", ""),
                                "transport": "plane",
                                "duration_min": ticket.get("duration_to", 0),
                                "stops": ticket.get("transfers", 0),
                                "departure_at": ticket.get("departure_at", ""),
                                "carrier": ticket.get("airline", ""),
                                "flight_number": ticket.get("flight_number", ""),
                            }
                        ),
                    )
                )

            route.total_transports = len(tickets[:3])
            await db.commit()
            logger.info(
                "[pipeline] flights: {} tickets for route {}",
                len(tickets[:3]),
                route_id,
            )
        except Exception as e:
            logger.warning("[pipeline] flights failed: {}", e)
