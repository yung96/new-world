"""
Trip API — frontend-facing endpoints that match the Travel Itinerary Page spec.
Adapts internal Route/Segment/SegmentItem models to the Trip/Segment/Block format.
"""
from __future__ import annotations

import json
from typing import Any

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import get_db_session
from app.models.route import Route, RouteSegment, SegmentItem

router = APIRouter(prefix="/trips")


def _format_duration(minutes: int | None) -> str | None:
    if not minutes:
        return None
    h = minutes // 60
    m = minutes % 60
    if h and m:
        return f"{h}h {m}m"
    if h:
        return f"{h}h"
    return f"{m}m"


def _item_to_block(item: SegmentItem, children: list[SegmentItem] | None = None) -> dict:
    """Convert SegmentItem to Block format expected by frontend."""
    item_type = item.type.value if hasattr(item.type, "value") else str(item.type)
    details = json.loads(item.details) if isinstance(item.details, str) else (item.details or {})

    if item_type == "leg":
        return {
            "type": "flight",
            "data": {
                "provider": item.provider_name or "",
                "provider_logo": None,
                "departure": {
                    "airport_code": details.get("from", ""),
                    "airport_name": details.get("from", ""),
                    "date": details.get("departure_at"),
                },
                "arrival": {
                    "airport_code": details.get("to", ""),
                    "airport_name": details.get("to", ""),
                    "date": details.get("arrival_at"),
                },
                "duration_minutes": details.get("duration_min"),
                "duration": _format_duration(details.get("duration_min")),
                "stops": details.get("stops", 0),
                "status": (
                    item.price_status.value
                    if item.price_status and hasattr(item.price_status, "value")
                    else "available"
                ),
                "price_per_person": item.price,
                "currency": item.price_currency or "RUB",
                "booking_url": item.provider_url,
            },
        }

    if item_type == "transfer":
        return {
            "type": "transfer",
            "data": {
                "title": details.get("from", "") + " → " + details.get("to", ""),
                "image": details.get("photo_url"),
                "travel_time_minutes": details.get("duration_min"),
                "travel_time": _format_duration(details.get("duration_min")),
                "price_per_person": item.price,
                "currency": item.price_currency or "RUB",
                "booking_url": item.provider_url,
            },
        }

    if item_type == "stay":
        return {
            "type": "stay",
            "data": {
                "hotel_name": details.get("name", ""),
                "image": details.get("photo_url"),
                "stars": details.get("stars"),
                "provider": details.get("source", item.provider_name),
                "rating": {
                    "score": details.get("rating"),
                    "label": details.get("rating_label", "Good"),
                    "reviews_count": details.get("review_count", 0),
                } if details.get("rating") else None,
                "check_in": details.get("check_in"),
                "check_out": details.get("check_out"),
                "nights": details.get("nights"),
                "total_price": item.price,
                "currency": item.price_currency or "RUB",
                "additional_charges": True,
                "booking_url": item.provider_url,
                "ai_recommendation": {
                    "text": item.ai_comment,
                    "highlights": [],
                } if item.ai_comment else None,
                # If this is a recommendation with options
                "options": details.get("options"),
                "recommendation_type": details.get("recommendation_type"),
            },
        }

    if item_type == "car_rental":
        return {
            "type": "car_rental",
            "data": {
                "model": details.get("model", ""),
                "class": details.get("class", ""),
                "transmission": details.get("transmission", ""),
                "doors": details.get("doors", ""),
                "image": details.get("photo_url"),
                "price_per_night": item.price,
                "currency": item.price_currency or "RUB",
                "booking_url": item.provider_url,
            },
        }

    if item_type == "day":
        experiences = []
        if children:
            for child in children:
                child_details = json.loads(child.details) if isinstance(child.details, str) else (child.details or {})
                exp: dict[str, Any] = {
                    "id": child.id,
                    "time": child_details.get("time"),
                    "title": child_details.get("name", ""),
                    "type": "activity",
                    "duration_minutes": child_details.get("duration_min"),
                    "description": child_details.get("description"),
                    "image": child_details.get("photo_url"),
                    "post_id": child_details.get("post_id"),
                    "lat": child_details.get("lat"),
                    "lng": child_details.get("lng"),
                    "distance_to_next_km": child_details.get("distance_to_next_km"),
                    "duration_to_next_min": child_details.get("duration_to_next_min"),
                    "transport_to_next": child_details.get("transport_to_next"),
                }
                # If this is a recommendation (food/stay/fuel)
                if child_details.get("recommendation_type"):
                    exp["type"] = "recommendation"
                    exp["recommendation_type"] = child_details["recommendation_type"]
                    exp["options"] = child_details.get("options", [])
                experiences.append(exp)

        return {
            "type": "itinerary_day",
            "data": {
                "day_number": details.get("day_number", 0),
                "date": details.get("date"),
                "experiences_count": details.get("experience_count", len(experiences)),
                "title": details.get("title", f"День {details.get('day_number', '')}"),
                "image": details.get("photo_url"),
                "weather": {
                    "temp_celsius": details.get("temp_c"),
                    "condition": details.get("weather_icon", "partly_cloudy"),
                } if details.get("temp_c") else None,
                "experiences": experiences,
            },
        }

    # Fallback for experience without parent (shouldn't happen normally)
    return {
        "type": "experience",
        "data": details,
    }


async def _build_trip_response(route: Route, db: AsyncSession) -> dict:
    """Build the full Trip response matching the frontend spec."""
    segments_result = await db.execute(
        select(RouteSegment)
        .where(RouteSegment.route_id == route.id)
        .order_by(RouteSegment.position)
    )
    segments = segments_result.scalars().all()

    params = route.params or {}
    destinations = [s.title for s in segments]

    trip_segments = []
    for seg in segments:
        # Load all items for this segment
        items_result = await db.execute(
            select(SegmentItem)
            .where(SegmentItem.segment_id == seg.id)
            .order_by(SegmentItem.position)
        )
        items = items_result.scalars().all()

        # Separate parent items from children
        parent_items = [i for i in items if i.parent_id is None]
        children_by_parent: dict[int, list[SegmentItem]] = {}
        for i in items:
            if i.parent_id is not None:
                children_by_parent.setdefault(i.parent_id, []).append(i)

        # Convert to blocks in the template order
        blocks = []

        for item in parent_items:
            item_type = item.type.value if hasattr(item.type, "value") else str(item.type)
            children = children_by_parent.get(item.id, [])

            if item_type == "day":
                block = _item_to_block(item, children)
            else:
                block = _item_to_block(item)

            blocks.append(block)

        trip_segments.append({
            "id": seg.id,
            "destination": seg.title,
            "date_from": seg.date_from.isoformat() if seg.date_from else None,
            "date_to": seg.date_to.isoformat() if seg.date_to else None,
            "narrative": seg.narrative,
            "order": seg.position,
            "blocks": blocks,
        })

    # Collect polyline from all experiences
    polyline = []
    for seg in segments:
        items = (await db.execute(
            select(SegmentItem)
            .where(SegmentItem.segment_id == seg.id, SegmentItem.type == "experience", SegmentItem.parent_id.isnot(None))
            .order_by(SegmentItem.position)
        )).scalars().all()
        for item in items:
            d = json.loads(item.details) if isinstance(item.details, str) else (item.details or {})
            lat, lng = d.get("lat"), d.get("lng")
            if lat and lng and not d.get("recommendation_type"):
                polyline.append([lat, lng])

    # Pricing
    total_price = route.total_price or 0

    weather = params.get("weather", {})
    events = params.get("events", [])
    offers = params.get("offers", [])

    return {
        "id": route.id,
        "title": route.title,
        "status": route.status.value if hasattr(route.status, "value") else str(route.status),
        "date_range": {
            "start": params.get("dateFrom"),
            "end": params.get("dateTo"),
        },
        "travellers_count": params.get("groupSize", 1),
        "group_type": params.get("groupType", "solo"),
        "currency": "RUB",
        "destinations": destinations,
        "hero_images": [],
        "narrative": route.narrative,
        "polyline": polyline,
        "share_token": route.share_token,
        "weather": weather,
        "events": events,
        "offers": offers,
        "segments": trip_segments,
        "meta": {
            "total_days": route.total_days,
            "total_experiences": route.total_experiences,
            "total_hotels": route.total_hotels,
            "total_transports": route.total_transports,
            "total_km": params.get("total_km"),
        },
        "pricing": {
            "original_total": total_price,
            "discounted_total": total_price,
            "currency": "RUB",
            "includes": "Маршрут + рекомендации",
        },
    }


# --- Endpoints ---

@router.get(
    "/{trip_id}",
    summary="Полный Trip object для страницы маршрута",
)
async def get_trip(
    trip_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, trip_id)
    if not route:
        raise HTTPException(status_code=404, detail="Trip not found")
    return await _build_trip_response(route, db)


@router.get(
    "/{trip_id}/day/{day_number}",
    summary="Детали дня (experiences)",
)
async def get_trip_day(
    trip_id: int,
    day_number: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, trip_id)
    if not route:
        raise HTTPException(status_code=404, detail="Trip not found")

    # Find the day item
    segments = (await db.execute(
        select(RouteSegment).where(RouteSegment.route_id == trip_id).order_by(RouteSegment.position)
    )).scalars().all()

    for seg in segments:
        items = (await db.execute(
            select(SegmentItem).where(SegmentItem.segment_id == seg.id, SegmentItem.type == "day")
            .order_by(SegmentItem.position)
        )).scalars().all()

        for item in items:
            details = json.loads(item.details) if isinstance(item.details, str) else (item.details or {})
            if details.get("day_number") == day_number:
                children = (await db.execute(
                    select(SegmentItem).where(SegmentItem.parent_id == item.id).order_by(SegmentItem.position)
                )).scalars().all()
                block = _item_to_block(item, children)
                return block["data"]

    raise HTTPException(status_code=404, detail=f"Day {day_number} not found")


@router.get(
    "/share/{share_token}",
    summary="Trip по share-токену (без авторизации)",
)
async def get_trip_by_share(
    share_token: str,
    db: AsyncSession = Depends(get_db_session),
):
    result = await db.execute(select(Route).where(Route.share_token == share_token))
    route = result.scalar_one_or_none()
    if not route:
        raise HTTPException(status_code=404, detail="Trip not found")
    return await _build_trip_response(route, db)


@router.get(
    "/{trip_id}/road",
    summary="GeoJSON дорога между точками маршрута (OSRM)",
)
async def get_trip_road(
    trip_id: int,
    transport: str = "driving",
    db: AsyncSession = Depends(get_db_session),
):
    """
    Возвращает GeoJSON LineString по реальным дорогам.
    transport: driving | walking | cycling
    """
    import httpx

    route = await db.get(Route, trip_id)
    if not route:
        raise HTTPException(status_code=404, detail="Trip not found")

    # Collect waypoints
    segments = (await db.execute(
        select(RouteSegment).where(RouteSegment.route_id == trip_id).order_by(RouteSegment.position)
    )).scalars().all()

    coords = []
    for seg in segments:
        items = (await db.execute(
            select(SegmentItem)
            .where(SegmentItem.segment_id == seg.id, SegmentItem.type == "experience", SegmentItem.parent_id.isnot(None))
            .order_by(SegmentItem.position)
        )).scalars().all()
        for item in items:
            d = json.loads(item.details) if isinstance(item.details, str) else (item.details or {})
            lat, lng = d.get("lat"), d.get("lng")
            if lat and lng and not d.get("recommendation_type"):
                coords.append(f"{lng},{lat}")

    if len(coords) < 2:
        return {"type": "FeatureCollection", "features": []}

    # OSRM
    profile = {"driving": "driving", "walking": "foot", "cycling": "bicycle"}.get(transport, "driving")
    osrm_coords = ";".join(coords)
    osrm_url = f"https://router.project-osrm.org/route/v1/{profile}/{osrm_coords}?overview=full&geometries=geojson"

    try:
        async with httpx.AsyncClient(timeout=15.0) as client:
            resp = await client.get(osrm_url)
            resp.raise_for_status()
            data = resp.json()

        if data.get("routes"):
            geometry = data["routes"][0]["geometry"]
            distance_m = data["routes"][0].get("distance", 0)
            duration_s = data["routes"][0].get("duration", 0)

            return {
                "geometry": geometry,
                "distance_km": round(distance_m / 1000, 1),
                "duration_min": round(duration_s / 60),
                "waypoints": [[float(c.split(",")[1]), float(c.split(",")[0])] for c in coords],
                "transport": transport,
            }
    except Exception as e:
        # Fallback: прямые линии
        pass

    # Fallback
    return {
        "geometry": {
            "type": "LineString",
            "coordinates": [[float(c.split(",")[0]), float(c.split(",")[1])] for c in coords],
        },
        "distance_km": None,
        "duration_min": None,
        "waypoints": [[float(c.split(",")[1]), float(c.split(",")[0])] for c in coords],
        "transport": transport,
        "source": "fallback",
    }


@router.get(
    "/{trip_id}/schedule",
    summary="Расписание маршрута — что делать, когда, сколько времени",
)
async def get_trip_schedule(
    trip_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, trip_id)
    if not route:
        raise HTTPException(status_code=404, detail="Trip not found")

    params = route.params or {}
    segments = (await db.execute(
        select(RouteSegment).where(RouteSegment.route_id == trip_id).order_by(RouteSegment.position)
    )).scalars().all()

    days = []
    for seg in segments:
        day_items = (await db.execute(
            select(SegmentItem).where(SegmentItem.segment_id == seg.id, SegmentItem.type == "day")
            .order_by(SegmentItem.position)
        )).scalars().all()

        for day_item in day_items:
            day_d = json.loads(day_item.details) if isinstance(day_item.details, str) else (day_item.details or {})

            exps = (await db.execute(
                select(SegmentItem).where(SegmentItem.parent_id == day_item.id).order_by(SegmentItem.position)
            )).scalars().all()

            activities = []
            recommendations = []

            for exp in exps:
                d = json.loads(exp.details) if isinstance(exp.details, str) else (exp.details or {})

                if d.get("recommendation_type"):
                    recommendations.append({
                        "type": d["recommendation_type"],
                        "options": d.get("options", []),
                    })
                else:
                    activities.append({
                        "time": d.get("time"),
                        "name": d.get("name", ""),
                        "description": d.get("description"),
                        "durationMin": d.get("duration_min"),
                        "lat": d.get("lat"),
                        "lng": d.get("lng"),
                        "postId": d.get("post_id"),
                        "distanceToNextKm": d.get("distance_to_next_km"),
                        "durationToNextMin": d.get("duration_to_next_min"),
                        "transportToNext": d.get("transport_to_next"),
                    })

            days.append({
                "dayNumber": day_d.get("day_number"),
                "date": day_d.get("date") or (seg.date_from.isoformat() if seg.date_from else None),
                "title": seg.title,
                "activitiesCount": len(activities),
                "totalDurationMin": sum(a.get("durationMin") or 0 for a in activities),
                "activities": activities,
                "recommendations": recommendations,
            })

    weather_per_day = params.get("weatherPerDay", [])

    # AI tips for activities
    ai_tips = None
    try:
        from app.core.config import settings
        key = getattr(settings, "GPT_CLIENT_KEY", None) or ""
        if key and key.lower() not in ("", "fake", "x"):
            from app.services.gpt_service import GptService
            ctx = json.dumps({
                "days": [
                    {"day": d["dayNumber"], "activities": [a["name"] for a in d["activities"]]}
                    for d in days
                ],
                "weather": weather_per_day[:3] if weather_per_day else [],
                "group": params.get("groupType", "solo"),
            }, ensure_ascii=False)
            prompt = (
                "Дай короткий совет (1 предложение) к каждой активности маршрута. "
                "Формат: JSON массив [{\"name\": \"...\", \"tip\": \"...\"}]. "
                "Советы практичные: что взять, во сколько лучше, на что обратить внимание. "
                "Контекст:\n" + ctx
            )
            gpt = GptService()
            try:
                resp = await gpt.request_openai_text_response(
                    sys_prompt="Ты — местный гид по Краснодарскому краю.",
                    user_prompt=prompt,
                    max_tokens=800,
                )
                raw = None
                if resp and hasattr(resp, 'choices') and resp.choices:
                    raw = resp.choices[0].message.content
                elif isinstance(resp, str):
                    raw = resp
                if raw:
                    # Parse JSON from response
                    import re
                    match = re.search(r'\[.*\]', raw, re.DOTALL)
                    if match:
                        ai_tips = json.loads(match.group())
            finally:
                await gpt.close()
    except Exception:
        pass

    # Merge tips into activities
    if ai_tips:
        tip_map = {t["name"]: t["tip"] for t in ai_tips if "name" in t and "tip" in t}
        for day in days:
            for act in day["activities"]:
                act["aiTip"] = tip_map.get(act["name"])

    return {
        "tripId": trip_id,
        "title": route.title,
        "totalDays": len(days),
        "totalKm": params.get("total_km"),
        "weather": weather_per_day,
        "days": days,
    }


# --- Place detail ---


@router.get(
    "/place/{post_id}",
    summary="Полная карточка места + отзывы + похожие + nearby",
)
async def get_place_detail(
    post_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    from sqlalchemy.orm import selectinload
    from app.models.post import Post
    from app.models.review import Review
    from app.models.schedule import PostMedia, PlaceSchedule
    from app.models.interest import Interest
    from app.models.event import Event, Offer
    from app.models.geo import GeoRegion
    from app.services.pipeline.helpers import nearest_n, haversine
    from datetime import date

    post = (await db.execute(
        select(Post)
        .where(Post.id == post_id)
        .options(selectinload(Post.media), selectinload(Post.interests))
    )).scalar_one_or_none()

    if not post:
        raise HTTPException(status_code=404, detail="Place not found")

    # Reviews
    reviews = (await db.execute(
        select(Review).where(Review.post_id == post_id).order_by(Review.created_at.desc()).limit(10)
    )).scalars().all()

    # Schedule
    schedule = (await db.execute(
        select(PlaceSchedule).where(PlaceSchedule.post_id == post_id).order_by(PlaceSchedule.day_of_week)
    )).scalars().all()

    # Region info
    region = None
    if post.region_id:
        region = await db.get(GeoRegion, post.region_id)

    # Nearby places
    all_posts = (await db.execute(
        select(Post).where(Post.geo_lat.isnot(None), Post.id != post_id).options(selectinload(Post.media))
    )).scalars().all()
    nearby = nearest_n(post.geo_lat or 0, post.geo_lng or 0, all_posts, 5, max_km=30)

    # Events at this place
    today = date.today()
    events = (await db.execute(
        select(Event).where(Event.post_id == post_id, Event.date_to >= today)
    )).scalars().all()

    # Offers at this place
    offers = (await db.execute(
        select(Offer).where(Offer.post_id == post_id, Offer.valid_to >= today)
    )).scalars().all()

    return {
        "id": post.id,
        "title": post.title,
        "description": post.description,
        "photos": [m.url for m in post.media] if post.media else [],
        "city": post.city,
        "region": {"id": region.id, "name": region.name} if region else None,
        "lat": post.geo_lat,
        "lng": post.geo_lng,
        "address": post.address,
        "phone": post.phone,
        "email": post.email,
        "website": post.website,
        "season": post.season.value if hasattr(post.season, "value") else str(post.season),
        "needCar": post.need_car,
        "priceLevel": post.price_level.value if post.price_level and hasattr(post.price_level, "value") else None,
        "durationHours": post.duration_hours,
        "bestAngle": post.best_angle,
        "verified": post.verified,
        "rating": {
            "avg": float(post.rating_avg) if post.rating_avg else None,
            "count": post.reviews_count,
        },
        "interests": [
            {"id": i.id, "name": i.name, "emoji": i.emoji}
            for i in post.interests
        ] if post.interests else [],
        "schedule": [
            {"dayOfWeek": s.day_of_week, "open": str(s.open_time) if s.open_time else None,
             "close": str(s.close_time) if s.close_time else None, "isClosed": s.is_closed}
            for s in schedule
        ],
        "reviews": [
            {
                "id": r.id,
                "rating": r.rating,
                "comment": r.comment,
                "createdAt": r.created_at.isoformat() if r.created_at else None,
            }
            for r in reviews
        ],
        "nearby": [
            {
                "id": p.id,
                "title": p.title,
                "description": p.description,
                "photo": p.media[0].url if p.media else None,
                "distanceKm": round(dist, 1),
                "city": p.city,
            }
            for p, dist in nearby
        ],
        "events": [
            {"id": e.id, "title": e.title, "description": e.description,
             "dateFrom": e.date_from.isoformat(), "dateTo": e.date_to.isoformat()}
            for e in events
        ],
        "offers": [
            {"id": o.id, "title": o.title, "description": o.description,
             "discount": o.discount_percent}
            for o in offers
        ],
    }


@router.get(
    "/place/{post_id}/ai",
    summary="ИИ-рекомендация по месту",
)
async def get_place_ai(
    post_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    from sqlalchemy.orm import selectinload
    from app.models.post import Post

    post = (await db.execute(
        select(Post).where(Post.id == post_id).options(selectinload(Post.interests))
    )).scalar_one_or_none()

    if not post:
        raise HTTPException(status_code=404, detail="Place not found")

    # Try GPT
    ai_text = None
    try:
        from app.core.config import settings
        key = getattr(settings, "GPT_CLIENT_KEY", None) or ""
        if key and key.lower() not in ("", "fake", "x"):
            from app.services.gpt_service import GptService
            prompt = (
                f"Место: {post.title}, {post.city}.\n"
                f"Описание: {post.description}\n"
                f"Сезон: {post.season}\n"
                f"Интересы: {', '.join(i.name for i in post.interests) if post.interests else 'нет'}\n\n"
                "Напиши 3-4 предложения от второго лица (вы):\n"
                "1. Почему стоит посетить\n"
                "2. Лучшее время для визита\n"
                "3. Практичный совет (что взять, сколько стоит, куда потом)\n"
                "Без слов 'уникальный', 'незабываемый'. Конкретика."
            )
            gpt = GptService()
            try:
                resp = await gpt.request_openai_text_response(
                    sys_prompt="Ты — местный гид по Краснодарскому краю. Кратко и по делу.",
                    user_prompt=prompt,
                    max_tokens=400,
                )
                if resp and hasattr(resp, 'choices') and resp.choices:
                    ai_text = resp.choices[0].message.content
                elif isinstance(resp, str):
                    ai_text = resp
            finally:
                await gpt.close()
    except Exception:
        pass

    if not ai_text:
        # Fallback
        interests_str = ", ".join(i.name.lower() for i in post.interests) if post.interests else "отдых"
        ai_text = (
            f"{post.title} — отличный выбор для тех, кто любит {interests_str}. "
            f"{post.description} "
            f"Лучшее время для посещения — {post.season}."
        )

    return {
        "postId": post.id,
        "title": post.title,
        "recommendation": ai_text,
    }
