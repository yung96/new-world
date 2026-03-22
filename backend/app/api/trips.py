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
        "hero_images": [],  # TODO: collect from segment photos
        "narrative": route.narrative,
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
