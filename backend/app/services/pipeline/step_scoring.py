from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select
from sqlalchemy.orm import selectinload

from app.db import async_session_factory
from app.models.post import Post
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import INTEREST_QUERIES, PACE_POINTS, season_from_dates


async def step_scoring(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        route = await db.get(Route, route_id)
        if not route:
            return

        interests = params.get("interests", [])
        pace = params.get("pace", "balanced")
        n = PACE_POINTS.get(pace, 5)
        budget = params.get("budget")
        transport = params.get("transport")
        season = season_from_dates(params.get("dateFrom"), params.get("dateTo"))

        search_terms = []
        for interest in interests:
            search_terms.extend(INTEREST_QUERIES.get(interest, [interest]))

        stmt = select(Post).where(Post.geo_lat.isnot(None))
        if budget == "low":
            stmt = stmt.where(Post.price_level.in_(["low", None]))
        if transport == "none":
            stmt = stmt.where(Post.need_car == False)
        stmt = stmt.options(selectinload(Post.interests)).limit(500)
        posts = (await db.execute(stmt)).scalars().all()

        scored = []
        for p in posts:
            post_interests = {i.name.lower() for i in p.interests}
            post_desc = (p.description or "").lower()
            score = 0
            for term in search_terms:
                if term.lower() in post_interests or term.lower() in post_desc:
                    score += 10
            if str(p.season) == season:
                score += 5
            scored.append((score, p))

        scored.sort(key=lambda x: -x[0])
        top_posts = [p for _, p in scored[:n]]

        if not top_posts:
            return

        seg = RouteSegment(route_id=route_id, position=0, title=route.title)
        db.add(seg)
        await db.flush()

        for i, p in enumerate(top_posts):
            db.add(SegmentItem(
                segment_id=seg.id, type="experience", position=i,
                details=json.dumps({
                    "name": p.title, "lat": p.geo_lat, "lng": p.geo_lng,
                    "post_id": p.id, "description": p.description,
                }),
            ))

        route.total_experiences = len(top_posts)
        await db.commit()
        logger.info("[pipeline] scoring: {} places for route {}", len(top_posts), route_id)
