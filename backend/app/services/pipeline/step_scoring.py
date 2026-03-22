from __future__ import annotations

import json
from datetime import date, timedelta
from typing import Any

from loguru import logger
from sqlalchemy import select
from sqlalchemy.orm import selectinload

from app.db import async_session_factory
from app.models.post import Post
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.pipeline.helpers import (
    INTEREST_QUERIES, PACE_POINTS, haversine, season_from_dates, parse_date,
)

# Points per day by pace
POINTS_PER_DAY = {"relaxed": 2, "balanced": 3, "intensive": 5}


def _cluster_nearby(posts: list[Post], max_km: float = 50) -> list[Post]:
    """Pick posts that are close to each other. Start with highest-scored, greedily add nearest."""
    if not posts:
        return []
    result = [posts[0]]
    remaining = list(posts[1:])

    while remaining:
        last = result[-1]
        best_idx, best_dist = 0, 999999.0
        for i, p in enumerate(remaining):
            d = haversine(last.geo_lat, last.geo_lng, p.geo_lat, p.geo_lng)
            if d < best_dist:
                best_dist = d
                best_idx = i
        # Stop if too far
        if best_dist > max_km:
            break
        result.append(remaining.pop(best_idx))

    return result


async def step_scoring(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        route = await db.get(Route, route_id)
        if not route:
            return

        interests = params.get("interests", [])
        pace = params.get("pace", "balanced")
        budget = params.get("budget")
        transport = params.get("transport")
        season = season_from_dates(params.get("dateFrom"), params.get("dateTo"))

        d_from = parse_date(params.get("dateFrom")) or date.today()
        d_to = parse_date(params.get("dateTo")) or d_from + timedelta(days=1)
        trip_days = max(1, (d_to - d_from).days + 1)

        ppd = POINTS_PER_DAY.get(pace, 3)
        total_points = trip_days * ppd

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

        # Map filter interests to DB interest names
        interest_name_map = {
            "gastro": "гастро", "wine": "вино", "eco": "эко",
            "nature": "природа", "culture": "культура", "relax": "отдых",
            "active": "активность", "workation": "workation",
        }
        wanted = {interest_name_map.get(i, i).lower() for i in interests}

        # Score by interest match + text match + season
        scored = []
        for p in posts:
            post_interest_names = {i.name.lower() for i in p.interests}
            post_desc = (p.description or "").lower()
            post_title = (p.title or "").lower()
            score = 0

            # Direct interest match (strongest signal)
            matched = wanted & post_interest_names
            score += len(matched) * 20

            # Text match in description/title
            for term in search_terms:
                t = term.lower()
                if t in post_desc or t in post_title:
                    score += 5

            # Season bonus
            if str(p.season) == season:
                score += 3

            # Every post with at least one interest gets a base score
            if post_interest_names:
                score += 2

            scored.append((score, p))

        scored.sort(key=lambda x: -x[0])
        # Take more candidates than needed, then cluster
        candidates = [p for sc, p in scored[:total_points * 3] if sc > 0]

        if not candidates:
            candidates = [p for _, p in scored[:total_points]]

        # Cluster: pick nearby points starting from best
        clustered = _cluster_nearby(candidates, max_km=80)[:total_points]

        if not clustered:
            return

        # Split into days
        route.total_days = trip_days
        route.total_experiences = len(clustered)

        for day_idx in range(trip_days):
            day_start = day_idx * ppd
            day_end = min(day_start + ppd, len(clustered))
            day_posts = clustered[day_start:day_end]
            if not day_posts:
                break

            current_date = d_from + timedelta(days=day_idx)

            seg = RouteSegment(
                route_id=route_id,
                position=day_idx,
                title=f"День {day_idx + 1}",
                date_from=current_date,
                date_to=current_date,
            )
            db.add(seg)
            await db.flush()

            # Day item
            day_item = SegmentItem(
                segment_id=seg.id,
                type="day",
                position=0,
                details=json.dumps({
                    "day_number": day_idx + 1,
                    "date": str(current_date),
                    "title": f"День {day_idx + 1}",
                    "experience_count": len(day_posts),
                }),
            )
            db.add(day_item)
            await db.flush()

            # Experiences inside day with auto-time
            START_HOUR = 9
            for i, p in enumerate(day_posts):
                hour = START_HOUR + i * 2  # every 2 hours
                time_str = f"{hour:02d}:00"
                db.add(SegmentItem(
                    segment_id=seg.id,
                    parent_id=day_item.id,
                    type="experience",
                    position=i,
                    details=json.dumps({
                        "name": p.title,
                        "lat": p.geo_lat,
                        "lng": p.geo_lng,
                        "post_id": p.id,
                        "description": p.description,
                        "time": time_str,
                        "duration_min": 90,
                    }),
                ))

        await db.commit()
        logger.info(
            "[pipeline] scoring: {} places, {} days for route {}",
            len(clustered), trip_days, route_id,
        )
