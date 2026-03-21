"""
Route builder pipeline.

Steps:
  1. scoring    — pick top places from DB by filters + interest weights
  2. distances  — compute distances/durations between points (2GIS/OSRM)
  3. recommend  — add food/stay/fuel recommendations near route points
  4. weather    — fetch weather for dates + region
  5. narrate    — LLM generates narrative, captions, reorders if needed

Each step updates the Route in DB and bumps status.
Frontend long-polls GET /routes/{id}/status.
"""

from __future__ import annotations

import json
import math
from datetime import date
from typing import Any

from loguru import logger
from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.db import async_session_factory
from app.models.post import Post
from app.models.interest import Interest
from app.models.route import Route, RouteSegment, SegmentItem
from app.models.geo import GeoRegion
from app.services.travel_service import TravelService


# Interest → 2GIS search queries
INTEREST_QUERIES: dict[str, list[str]] = {
    "gastro": ["ресторан", "кафе", "столовая"],
    "wine": ["винодельня", "винный бар", "дегустация"],
    "eco": ["экотропа", "заповедник", "нацпарк"],
    "nature": ["водопад", "смотровая площадка", "парк"],
    "culture": ["музей", "театр", "галерея"],
    "relax": ["спа", "термальный источник", "пляж"],
    "active": ["прокат велосипедов", "рафтинг", "скалодром"],
    "workation": ["коворкинг", "кофейня с wifi"],
}

# Recommendation types by filter context
RECOMMEND_QUERIES: dict[str, str] = {
    "food": "кафе ресторан",
    "stay": "гостиница отель хостел",
    "fuel": "заправка АЗС",
}

PACE_POINTS = {"relaxed": 3, "balanced": 5, "intensive": 8}


def _haversine(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    R = 6371
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) ** 2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon / 2) ** 2
    return 2 * R * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def _season_from_dates(d_from: date | None, d_to: date | None) -> str:
    d = d_from or date.today()
    m = d.month
    if m in (3, 4, 5):
        return "spring"
    if m in (6, 7, 8):
        return "summer"
    if m in (9, 10, 11):
        return "autumn"
    return "winter"


class RouteBuilder:
    """Async pipeline that builds a route step-by-step."""

    def __init__(self, route_id: int, params: dict[str, Any]):
        self.route_id = route_id
        self.params = params
        self.travel = TravelService()

    async def run(self) -> None:
        """Run full pipeline. Called via scheduler.run_once."""
        try:
            await self._step_scoring()
            await self._step_distances()
            await self._step_recommend()
            await self._step_weather()
            await self._step_narrate()
        except Exception as e:
            logger.error("[route_builder] route {} failed: {}", self.route_id, e)
            await self._set_status("stale")

    async def _set_status(self, status: str) -> None:
        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if route:
                route.status = status
                await db.commit()

    # ── Step 1: Scoring ──────────────────────────────────────────────────

    async def _step_scoring(self) -> None:
        await self._set_status("scoring")
        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if not route:
                return

            interests = self.params.get("interests", [])
            pace = self.params.get("pace", "balanced")
            n = PACE_POINTS.get(pace, 5)
            budget = self.params.get("budget")
            transport = self.params.get("transport")
            season = _season_from_dates(
                self.params.get("date_from"),
                self.params.get("date_to"),
            )

            # Build interest queries
            search_terms = []
            for interest in interests:
                search_terms.extend(INTEREST_QUERIES.get(interest, [interest]))

            # Find region centroid for bbox
            region = None
            if route.params and route.params.get("region_id"):
                region = await db.get(GeoRegion, route.params["region_id"])

            # Load posts matching season + budget
            stmt = select(Post).where(Post.geo_lat.isnot(None))

            if budget == "low":
                stmt = stmt.where(Post.price_level.in_(["low", None]))
            elif budget == "high":
                stmt = stmt.where(Post.price_level.in_(["mid", "high", None]))

            if transport == "none":
                stmt = stmt.where(Post.need_car == False)

            stmt = stmt.options(selectinload(Post.interests)).limit(500)
            posts = (await db.execute(stmt)).scalars().all()

            # Score by interest match
            scored = []
            for p in posts:
                post_interests = {i.name.lower() for i in p.interests}
                post_desc = (p.description or "").lower()
                score = 0
                for term in search_terms:
                    if term.lower() in post_interests or term.lower() in post_desc:
                        score += 10
                if str(p.season) == season or p.season is None:
                    score += 5
                scored.append((score, p))

            scored.sort(key=lambda x: -x[0])
            top_posts = [p for _, p in scored[:n]]

            if not top_posts:
                await self._set_status("stale")
                return

            # Create segment + items
            seg = RouteSegment(
                route_id=self.route_id,
                position=0,
                title=route.title,
            )
            db.add(seg)
            await db.flush()

            for i, p in enumerate(top_posts):
                item = SegmentItem(
                    segment_id=seg.id,
                    type="experience",
                    position=i,
                    details=json.dumps({
                        "name": p.title,
                        "lat": p.geo_lat,
                        "lng": p.geo_lng,
                        "post_id": p.id,
                        "description": p.description,
                    }),
                )
                db.add(item)

            route.total_experiences = len(top_posts)
            await db.commit()
            logger.info("[route_builder] step1 scoring: {} places for route {}", len(top_posts), self.route_id)

    # ── Step 2: Distances ────────────────────────────────────────────────

    async def _step_distances(self) -> None:
        await self._set_status("distances")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem)
                .join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience")
                .order_by(SegmentItem.position)
            )).scalars().all()

            if len(items) < 2:
                return

            coords = []
            for item in items:
                d = json.loads(item.details or "{}")
                coords.append((d.get("lat", 0), d.get("lng", 0)))

            # Calculate haversine distances between consecutive points
            for i in range(len(items) - 1):
                dist = _haversine(coords[i][0], coords[i][1], coords[i + 1][0], coords[i + 1][1])
                d = json.loads(items[i].details or "{}")
                d["distance_to_next_km"] = round(dist, 1)
                d["duration_to_next_min"] = round(dist / 40 * 60)  # ~40km/h estimate
                items[i].details = json.dumps(d)

            await db.commit()
            logger.info("[route_builder] step2 distances: route {}", self.route_id)

    # ── Step 3: Recommendations ──────────────────────────────────────────

    async def _step_recommend(self) -> None:
        await self._set_status("enriching")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem)
                .join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience")
                .order_by(SegmentItem.position)
            )).scalars().all()

            if not items:
                return

            seg_id = items[0].segment_id
            rec_position = len(items)

            # For each main point, find nearby food/stay from our DB
            for item in items:
                d = json.loads(item.details or "{}")
                lat, lng = d.get("lat", 0), d.get("lng", 0)
                if not lat or not lng:
                    continue

                # Find nearest food
                food = (await db.execute(
                    select(Post)
                    .where(
                        Post.description.in_(["Ресторан", "Кафе"]),
                        Post.geo_lat.isnot(None),
                    )
                    .limit(100)
                )).scalars().all()

                nearest_food = None
                best_dist = 999
                for f in food:
                    dist = _haversine(lat, lng, f.geo_lat, f.geo_lng)
                    if dist < best_dist and dist < 5:  # within 5km
                        best_dist = dist
                        nearest_food = f

                if nearest_food:
                    rec = SegmentItem(
                        segment_id=seg_id,
                        parent_id=item.id,
                        type="experience",
                        position=rec_position,
                        details=json.dumps({
                            "name": nearest_food.title,
                            "lat": nearest_food.geo_lat,
                            "lng": nearest_food.geo_lng,
                            "post_id": nearest_food.id,
                            "description": nearest_food.description,
                            "recommendation_type": "food",
                        }),
                    )
                    db.add(rec)
                    rec_position += 1

            # Find nearest stay for the route
            first_d = json.loads(items[0].details or "{}")
            lat, lng = first_d.get("lat", 0), first_d.get("lng", 0)
            stays = (await db.execute(
                select(Post)
                .where(Post.description == "Гостиница", Post.geo_lat.isnot(None))
                .limit(50)
            )).scalars().all()

            nearest_stay = None
            best_dist = 999
            for s in stays:
                dist = _haversine(lat, lng, s.geo_lat, s.geo_lng)
                if dist < best_dist:
                    best_dist = dist
                    nearest_stay = s

            if nearest_stay:
                rec = SegmentItem(
                    segment_id=seg_id,
                    parent_id=None,
                    type="stay",
                    position=rec_position,
                    details=json.dumps({
                        "name": nearest_stay.title,
                        "lat": nearest_stay.geo_lat,
                        "lng": nearest_stay.geo_lng,
                        "post_id": nearest_stay.id,
                        "recommendation_type": "stay",
                    }),
                )
                db.add(rec)

            await db.commit()
            logger.info("[route_builder] step3 recommend: route {}", self.route_id)

    # ── Step 4: Weather ──────────────────────────────────────────────────

    async def _step_weather(self) -> None:
        await self._set_status("weather")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem)
                .join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience")
                .order_by(SegmentItem.position)
                .limit(1)
            )).scalars().first()

            if not items:
                return

            d = json.loads(items.details or "{}")
            lat, lng = d.get("lat"), d.get("lng")
            if not lat or not lng:
                return

            try:
                weather = await self.travel.get_weather_info(lat, lng)
                route = await db.get(Route, self.route_id)
                if route and route.params:
                    params = dict(route.params)
                    params["weather"] = weather
                    route.params = params
                    await db.commit()
            except Exception as e:
                logger.warning("[route_builder] weather failed: {}", e)

            logger.info("[route_builder] step4 weather: route {}", self.route_id)

    # ── Step 5: LLM Narrate ──────────────────────────────────────────────

    async def _step_narrate(self) -> None:
        await self._set_status("narrating")
        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if not route:
                return

            items = (await db.execute(
                select(SegmentItem)
                .join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience", SegmentItem.parent_id.is_(None))
                .order_by(SegmentItem.position)
            )).scalars().all()

            if not items:
                await self._set_status("ready")
                return

            # Build context for LLM
            stops = []
            for item in items:
                d = json.loads(item.details or "{}")
                stops.append({
                    "name": d.get("name", ""),
                    "description": (d.get("description") or "")[:200],
                    "lat": d.get("lat"),
                    "lng": d.get("lng"),
                })

            weather = (route.params or {}).get("weather", {})
            interests = self.params.get("interests", [])
            group_type = self.params.get("group_type", "solo")

            # For now: stub narrative (LLM call will replace this)
            narrative_parts = []
            narrative_parts.append(f"Маршрут для {group_type} по {len(stops)} точкам.")
            if weather.get("temperature"):
                narrative_parts.append(f"Погода: {weather.get('weather', '')}, {weather.get('temperature')}°C.")
            for i, s in enumerate(stops):
                narrative_parts.append(f"{i+1}. {s['name']}: {s['description'][:100]}")

            route.narrative = "\n".join(narrative_parts)
            route.status = "ready"
            await db.commit()
            logger.info("[route_builder] step5 narrate: route {} READY", self.route_id)
