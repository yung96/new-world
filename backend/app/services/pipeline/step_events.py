from __future__ import annotations

from datetime import date, timedelta
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.event import Event, Offer
from app.models.route import Route
from app.services.pipeline.helpers import parse_date


async def step_events(route_id: int, params: dict[str, Any]) -> None:
    d_from = parse_date(params.get("dateFrom")) or date.today()
    d_to = parse_date(params.get("dateTo")) or d_from + timedelta(days=3)

    async with async_session_factory() as db:
        events = (await db.execute(
            select(Event).where(Event.date_from <= d_to, Event.date_to >= d_from)
        )).scalars().all()

        offers = (await db.execute(
            select(Offer).where(Offer.valid_from <= d_to, Offer.valid_to >= d_from)
        )).scalars().all()

        route = await db.get(Route, route_id)
        if route and route.params:
            p = dict(route.params)
            p["events"] = [
                {"id": e.id, "title": e.title, "description": e.description,
                 "dateFrom": str(e.date_from), "dateTo": str(e.date_to)}
                for e in events
            ]
            p["offers"] = [
                {"id": o.id, "title": o.title, "description": o.description,
                 "discount": o.discount_percent, "validFrom": str(o.valid_from), "validTo": str(o.valid_to)}
                for o in offers
            ]
            route.params = p
            await db.commit()

        logger.info("[pipeline] events: {} events, {} offers for route {}", len(events), len(offers), route_id)
