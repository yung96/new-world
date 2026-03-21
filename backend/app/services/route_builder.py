"""
Route builder pipeline — 7 steps.

  1. scoring    — pick top places by filters + interest weights
  2. flights    — search Aviasales if transport=car/public and trip is inter-city
  3. distances  — compute distances/durations between points
  4. recommend  — 2-3 food options, 2-3 stay options, fuel near each point
  5. events     — find events/offers on trip dates
  6. weather    — weather forecast per day
  7. narrate    — LLM: narrative, per-stop captions, tips, reorder

Each step updates Route in DB, bumps status.
Frontend long-polls GET /routes/{id}/status.
"""

from __future__ import annotations

import json
import math
from datetime import date, timedelta
from typing import Any

from loguru import logger
from sqlalchemy import select, func, and_
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.db import async_session_factory
from app.models.post import Post
from app.models.interest import Interest
from app.models.event import Event, Offer
from app.models.route import Route, RouteSegment, SegmentItem
from app.models.geo import GeoRegion
from app.services.travel_service import TravelService


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

PACE_POINTS = {"relaxed": 3, "balanced": 5, "intensive": 8}


def _haversine(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    R = 6371
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) ** 2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon / 2) ** 2
    return 2 * R * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def _season_from_dates(d_from: str | date | None, d_to: str | date | None) -> str:
    if isinstance(d_from, str):
        d_from = date.fromisoformat(d_from)
    d = d_from or date.today()
    m = d.month
    if m in (3, 4, 5): return "spring"
    if m in (6, 7, 8): return "summer"
    if m in (9, 10, 11): return "autumn"
    return "winter"


def _parse_date(val: str | date | None) -> date | None:
    if val is None: return None
    if isinstance(val, date): return val
    return date.fromisoformat(val)


def _nearest_n(lat: float, lng: float, posts: list[Post], n: int, max_km: float = 10) -> list[tuple[Post, float]]:
    """Find N nearest posts within max_km."""
    scored = []
    for p in posts:
        if not p.geo_lat or not p.geo_lng:
            continue
        d = _haversine(lat, lng, p.geo_lat, p.geo_lng)
        if d <= max_km:
            scored.append((p, d))
    scored.sort(key=lambda x: x[1])
    return scored[:n]


class RouteBuilder:
    def __init__(self, route_id: int, params: dict[str, Any]):
        self.route_id = route_id
        self.params = params
        self.travel = TravelService()

    async def run(self) -> None:
        try:
            await self._step_scoring()
            await self._step_flights()
            await self._step_distances()
            await self._step_recommend()
            await self._step_events()
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
            season = _season_from_dates(self.params.get("dateFrom"), self.params.get("dateTo"))

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
                await self._set_status("stale")
                return

            seg = RouteSegment(route_id=self.route_id, position=0, title=route.title)
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
            logger.info("[route_builder] step1 scoring: {} places for route {}", len(top_posts), self.route_id)

    # ── Step 2: Flights ──────────────────────────────────────────────────

    async def _step_flights(self) -> None:
        await self._set_status("flights")
        transport = self.params.get("transport")
        date_from = self.params.get("dateFrom")

        if transport == "none" or not date_from:
            logger.info("[route_builder] step2 flights: skipped (transport={}, no dates)", transport)
            return

        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if not route:
                return

            seg = (await db.execute(
                select(RouteSegment).where(RouteSegment.route_id == self.route_id).limit(1)
            )).scalar_one_or_none()
            if not seg:
                return

            try:
                # Search flights from Moscow to Krasnodar region
                flight_data = await self.travel.get_global_route({
                    "origin": "Москва",
                    "destination": "Краснодар",
                    "departure_at": str(date_from)[:7],  # YYYY-MM
                    "one_way": True,
                    "limit": 3,
                    "sorting": "price",
                    "currency": "rub",
                    "market": "ru",
                })

                tickets = flight_data.get("data", [])
                for i, ticket in enumerate(tickets[:3]):
                    db.add(SegmentItem(
                        segment_id=seg.id, type="leg", position=-(3 - i),
                        price=ticket.get("price"),
                        price_currency="RUB",
                        provider_name=ticket.get("airline", ""),
                        provider_url=f"https://www.aviasales.ru{ticket.get('link', '')}",
                        details=json.dumps({
                            "from": ticket.get("origin", ""),
                            "to": ticket.get("destination", ""),
                            "transport": "plane",
                            "duration_min": ticket.get("duration_to", 0),
                            "stops": ticket.get("transfers", 0),
                            "departure_at": ticket.get("departure_at", ""),
                            "carrier": ticket.get("airline", ""),
                            "flight_number": ticket.get("flight_number", ""),
                        }),
                    ))

                route.total_transports = len(tickets[:3])
                await db.commit()
                logger.info("[route_builder] step2 flights: {} tickets for route {}", len(tickets[:3]), self.route_id)
            except Exception as e:
                logger.warning("[route_builder] step2 flights failed: {}", e)

    # ── Step 3: Distances ────────────────────────────────────────────────

    async def _step_distances(self) -> None:
        await self._set_status("distances")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem).join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience")
                .order_by(SegmentItem.position)
            )).scalars().all()

            if len(items) < 2:
                return

            total_km = 0
            for i in range(len(items) - 1):
                d1 = json.loads(items[i].details or "{}")
                d2 = json.loads(items[i + 1].details or "{}")
                dist = _haversine(d1.get("lat", 0), d1.get("lng", 0), d2.get("lat", 0), d2.get("lng", 0))
                total_km += dist

                transport = self.params.get("transport", "car")
                speed = 60 if transport == "car" else 15  # km/h
                d1["distance_to_next_km"] = round(dist, 1)
                d1["duration_to_next_min"] = round(dist / speed * 60)
                d1["transport_to_next"] = transport
                items[i].details = json.dumps(d1)

            # Update route total
            route = await db.get(Route, self.route_id)
            if route and route.params:
                p = dict(route.params)
                p["total_km"] = round(total_km, 1)
                route.params = p

            await db.commit()
            logger.info("[route_builder] step3 distances: {:.0f}km for route {}", total_km, self.route_id)

    # ── Step 4: Recommendations ──────────────────────────────────────────

    async def _step_recommend(self) -> None:
        await self._set_status("enriching")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem).join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience", SegmentItem.parent_id.is_(None))
                .order_by(SegmentItem.position)
            )).scalars().all()

            if not items:
                return

            seg_id = items[0].segment_id

            # Load all food and stay posts
            food_posts = (await db.execute(
                select(Post).where(Post.description.in_(["Ресторан", "Кафе"]), Post.geo_lat.isnot(None))
            )).scalars().all()

            stay_posts = (await db.execute(
                select(Post).where(Post.description.in_(["Гостиница", "Кемпинг / Глэмпинг"]), Post.geo_lat.isnot(None))
            )).scalars().all()

            rec_pos = 1000  # high position to not conflict

            for item in items:
                d = json.loads(item.details or "{}")
                lat, lng = d.get("lat", 0), d.get("lng", 0)
                if not lat or not lng:
                    continue

                # 2-3 nearest restaurants
                nearest_food = _nearest_n(lat, lng, food_posts, 3)
                food_options = []
                for fp, dist in nearest_food:
                    food_options.append({"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                                         "lat": fp.geo_lat, "lng": fp.geo_lng, "type": fp.description})

                if food_options:
                    db.add(SegmentItem(
                        segment_id=seg_id, parent_id=item.id, type="experience", position=rec_pos,
                        details=json.dumps({"recommendation_type": "food", "options": food_options}),
                    ))
                    rec_pos += 1

            # 2-3 nearest stays for the whole route (from first point)
            first_d = json.loads(items[0].details or "{}")
            nearest_stays = _nearest_n(first_d.get("lat", 0), first_d.get("lng", 0), stay_posts, 3, max_km=50)
            stay_options = []
            for sp, dist in nearest_stays:
                stay_options.append({"name": sp.title, "post_id": sp.id, "distance_km": round(dist, 1),
                                     "lat": sp.geo_lat, "lng": sp.geo_lng, "type": sp.description})

            if stay_options:
                db.add(SegmentItem(
                    segment_id=seg_id, parent_id=None, type="stay", position=rec_pos,
                    details=json.dumps({"recommendation_type": "stay", "options": stay_options}),
                ))
                rec_pos += 1

            # Fuel if transport=car
            if self.params.get("transport") == "car":
                fuel_posts = (await db.execute(
                    select(Post).where(Post.description == "Автозаправочная станция", Post.geo_lat.isnot(None))
                )).scalars().all()

                mid_item = items[len(items) // 2]
                mid_d = json.loads(mid_item.details or "{}")
                nearest_fuel = _nearest_n(mid_d.get("lat", 0), mid_d.get("lng", 0), fuel_posts, 2)
                fuel_options = [{"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                                 "lat": fp.geo_lat, "lng": fp.geo_lng} for fp, dist in nearest_fuel]

                if fuel_options:
                    db.add(SegmentItem(
                        segment_id=seg_id, parent_id=mid_item.id, type="experience", position=rec_pos,
                        details=json.dumps({"recommendation_type": "fuel", "options": fuel_options}),
                    ))

            await db.commit()
            logger.info("[route_builder] step4 recommend: route {}", self.route_id)

    # ── Step 5: Events ───────────────────────────────────────────────────

    async def _step_events(self) -> None:
        await self._set_status("events")
        d_from = _parse_date(self.params.get("dateFrom"))
        d_to = _parse_date(self.params.get("dateTo"))

        if not d_from:
            d_from = date.today()
        if not d_to:
            d_to = d_from + timedelta(days=3)

        async with async_session_factory() as db:
            # Events overlapping trip dates
            events = (await db.execute(
                select(Event).where(
                    Event.date_from <= d_to,
                    Event.date_to >= d_from,
                )
            )).scalars().all()

            # Active offers
            offers = (await db.execute(
                select(Offer).where(
                    Offer.valid_from <= d_to,
                    Offer.valid_to >= d_from,
                )
            )).scalars().all()

            route = await db.get(Route, self.route_id)
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

            logger.info("[route_builder] step5 events: {} events, {} offers for route {}",
                        len(events), len(offers), self.route_id)

    # ── Step 6: Weather ──────────────────────────────────────────────────

    async def _step_weather(self) -> None:
        await self._set_status("weather")
        async with async_session_factory() as db:
            items = (await db.execute(
                select(SegmentItem).join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience", SegmentItem.parent_id.is_(None))
                .order_by(SegmentItem.position).limit(1)
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
                    p = dict(route.params)
                    p["weather"] = weather

                    # Per-day weather (estimate: same location, offset by day)
                    d_from = _parse_date(self.params.get("dateFrom"))
                    d_to = _parse_date(self.params.get("dateTo"))
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
                logger.warning("[route_builder] weather failed: {}", e)

            logger.info("[route_builder] step6 weather: route {}", self.route_id)

    # ── Step 7: LLM Narrate ──────────────────────────────────────────────

    async def _step_narrate(self) -> None:
        await self._set_status("narrating")
        async with async_session_factory() as db:
            route = await db.get(Route, self.route_id)
            if not route:
                return

            items = (await db.execute(
                select(SegmentItem).join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.type == "experience", SegmentItem.parent_id.is_(None))
                .order_by(SegmentItem.position)
            )).scalars().all()

            # Collect all recommendations
            recs = (await db.execute(
                select(SegmentItem).join(RouteSegment)
                .where(RouteSegment.route_id == self.route_id, SegmentItem.parent_id.isnot(None))
            )).scalars().all()

            if not items:
                await self._set_status("ready")
                return

            # Build context for LLM
            params = route.params or {}
            stops_ctx = []
            for item in items:
                d = json.loads(item.details or "{}")
                stops_ctx.append({
                    "name": d.get("name", ""),
                    "description": (d.get("description") or "")[:200],
                    "lat": d.get("lat"),
                    "lng": d.get("lng"),
                    "distance_to_next_km": d.get("distance_to_next_km"),
                    "duration_to_next_min": d.get("duration_to_next_min"),
                })

            recs_ctx = []
            for rec in recs:
                d = json.loads(rec.details or "{}")
                if d.get("recommendation_type"):
                    recs_ctx.append({
                        "type": d["recommendation_type"],
                        "options": d.get("options", []),
                    })

            llm_context = {
                "filters": {
                    "groupType": params.get("groupType", "solo"),
                    "transport": params.get("transport", "car"),
                    "budget": params.get("budget", "mid"),
                    "interests": params.get("interests", []),
                    "pace": params.get("pace", "balanced"),
                    "dateFrom": params.get("dateFrom"),
                    "dateTo": params.get("dateTo"),
                },
                "weather": params.get("weather", {}),
                "weatherPerDay": params.get("weatherPerDay", []),
                "events": params.get("events", []),
                "offers": params.get("offers", []),
                "stops": stops_ctx,
                "recommendations": recs_ctx,
                "totalKm": params.get("total_km", 0),
            }

            # TODO: Replace stub with real LLM call
            # For now: structured stub narrative
            weather = params.get("weather", {})
            group = params.get("groupType", "solo")
            interests = params.get("interests", [])
            events = params.get("events", [])
            offers = params.get("offers", [])

            lines = []
            lines.append(f"Маршрут для {group}, {len(stops_ctx)} точек, {params.get('total_km', '?')} км.")

            if weather.get("temperature"):
                lines.append(f"Погода: {weather.get('weather', '')}, {weather.get('temperature')}°C.")

            lines.append("")
            for i, s in enumerate(stops_ctx):
                line = f"{i+1}. {s['name']}"
                if s.get("description"):
                    line += f" — {s['description'][:80]}"
                if s.get("distance_to_next_km"):
                    line += f" (→ {s['distance_to_next_km']} км, ~{s['duration_to_next_min']} мин)"
                lines.append(line)

            if events:
                lines.append("")
                lines.append("События на ваши даты:")
                for e in events:
                    lines.append(f"  • {e['title']} ({e['dateFrom']} — {e['dateTo']})")

            if offers:
                lines.append("")
                lines.append("Актуальные акции:")
                for o in offers:
                    lines.append(f"  • {o['title']}: {o['description']}")

            route.narrative = "\n".join(lines)

            # Store LLM context for future real LLM call
            if route.params:
                p = dict(route.params)
                p["llm_context"] = llm_context
                route.params = p

            route.status = "ready"
            await db.commit()
            logger.info("[route_builder] step7 narrate: route {} READY", self.route_id)
