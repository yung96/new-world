"""Route builder — orchestrates 7 pipeline steps."""

from __future__ import annotations

from typing import Any

from loguru import logger

from app.db import async_session_factory
from app.models.route import Route
from app.services.pipeline.step_scoring import step_scoring
from app.services.pipeline.step_flights import step_flights
from app.services.pipeline.step_distances import step_distances
from app.services.pipeline.step_recommend import step_recommend
from app.services.pipeline.step_events import step_events
from app.services.pipeline.step_weather import step_weather
from app.services.pipeline.step_narrate import step_narrate


STEPS = [
    ("scoring", step_scoring),
    ("flights", step_flights),
    ("distances", step_distances),
    ("enriching", step_recommend),
    ("events", step_events),
    ("weather", step_weather),
    ("narrating", step_narrate),
]


class RouteBuilder:
    def __init__(self, route_id: int, params: dict[str, Any]):
        self.route_id = route_id
        self.params = params

    async def run(self) -> None:
        try:
            for status_name, step_fn in STEPS:
                await self._set_status(status_name)
                await step_fn(self.route_id, self.params)
        except Exception as e:
            logger.error("[pipeline] route {} failed at step: {}", self.route_id, e)
            await self._set_status("stale")

    async def _set_status(self, status: str) -> None:
        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if route:
                route.status = status
                await db.commit()
