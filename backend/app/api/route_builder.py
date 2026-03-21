from __future__ import annotations

import json
from datetime import date
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Request, status
from pydantic import BaseModel, Field
from sqlalchemy import and_, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.booking import Booking
from app.models.route import Route, RoutePin, RouteSegment, PinSource, PinType, SegmentItem
from app.models.user import User

router = APIRouter(prefix="/routes")


# ---------------------------------------------------------------------------
# Request / Response schemas
# ---------------------------------------------------------------------------

class RouteBuildRequest(BaseModel):
    dateFrom: date | None = None
    dateTo: date | None = None
    groupType: str | None = None
    groupSize: int | None = Field(default=None, ge=1, le=20)
    transport: str | None = None
    budget: str | None = None
    interests: list[str] | None = None
    pace: str | None = None
    regionId: int | None = None


class RouteBuildResponse(BaseModel):
    routeId: int
    status: str


class RouteStatusResponse(BaseModel):
    routeId: int
    status: str
    title: str | None
    narrative: str | None
    totalExperiences: int


class CreatePinRequest(BaseModel):
    label: str
    pinType: str
    lat: float
    lng: float
    icon: Optional[str] = None
    color: Optional[str] = None
    notes: Optional[str] = None


# ---------------------------------------------------------------------------
# Helper: serialize a single SegmentItem to a plain dict (camelCase)
# ---------------------------------------------------------------------------

def _serialize_item(item: SegmentItem) -> dict:
    return {
        "id": item.id,
        "type": item.type.value if hasattr(item.type, "value") else str(item.type),
        "position": item.position,
        "price": item.price,
        "priceCurrency": item.price_currency,
        "priceOriginal": item.price_original,
        "priceStatus": (
            item.price_status.value
            if hasattr(item.price_status, "value")
            else str(item.price_status)
        ),
        "providerName": item.provider_name,
        "providerUrl": item.provider_url,
        "aiComment": item.ai_comment,
        "details": json.loads(item.details) if isinstance(item.details, str) else item.details,
    }


# ---------------------------------------------------------------------------
# Helper: build the full route response dict
# ---------------------------------------------------------------------------

async def _build_full_response(route: Route, db: AsyncSession) -> dict:
    segments_result = await db.execute(
        select(RouteSegment)
        .where(RouteSegment.route_id == route.id)
        .order_by(RouteSegment.position)
    )
    segments = segments_result.scalars().all()

    serialized_segments = []

    for seg in segments:
        items_result = await db.execute(
            select(SegmentItem)
            .where(
                and_(
                    SegmentItem.segment_id == seg.id,
                    SegmentItem.parent_id.is_(None),
                )
            )
            .order_by(SegmentItem.position)
        )
        items = items_result.scalars().all()

        legs: list[dict] = []
        transfers: list[dict] = []
        stays: list[dict] = []
        car_rentals: list[dict] = []
        days: list[dict] = []

        for item in items:
            item_type = item.type.value if hasattr(item.type, "value") else str(item.type)
            serialized = _serialize_item(item)

            if item_type == "leg":
                legs.append(serialized)
            elif item_type == "transfer":
                transfers.append(serialized)
            elif item_type == "stay":
                stays.append(serialized)
            elif item_type == "car_rental":
                car_rentals.append(serialized)
            elif item_type == "day":
                # Load child experiences for this day
                exp_result = await db.execute(
                    select(SegmentItem)
                    .where(
                        and_(
                            SegmentItem.parent_id == item.id,
                            SegmentItem.type == "experience",
                        )
                    )
                    .order_by(SegmentItem.position)
                )
                experiences = [_serialize_item(e) for e in exp_result.scalars().all()]
                day_dict = serialized.copy()
                day_dict["experiences"] = experiences
                days.append(day_dict)

        serialized_segments.append({
            "id": seg.id,
            "title": seg.title,
            "description": seg.description,
            "narrative": seg.narrative,
            "dateFrom": seg.date_from.isoformat() if seg.date_from else None,
            "dateTo": seg.date_to.isoformat() if seg.date_to else None,
            "photos": seg.photos,
            "legs": legs,
            "transfers": transfers,
            "stays": stays,
            "carRentals": car_rentals,
            "days": days,
        })

    return {
        "id": route.id,
        "title": route.title,
        "narrative": route.narrative,
        "coverUrl": route.cover_url,
        "totalDays": route.total_days,
        "totalPrice": route.total_price,
        "totalPriceStatus": (
            route.total_price_status.value
            if hasattr(route.total_price_status, "value")
            else str(route.total_price_status)
        ),
        "totalExperiences": route.total_experiences,
        "totalHotels": route.total_hotels,
        "totalTransports": route.total_transports,
        "shareToken": route.share_token,
        "params": route.params,
        "status": (
            route.status.value
            if hasattr(route.status, "value")
            else str(route.status)
        ),
        "cityCount": len(segments),
        "segments": serialized_segments,
    }


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

@router.post(
    "/build",
    response_model=RouteBuildResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Начать построение маршрута",
)
async def build_route(
    body: RouteBuildRequest,
    request: Request,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    from app.services.pipeline import RouteBuilder

    params = body.model_dump(exclude_none=True, mode="json")

    route = Route(
        author_id=user.id,
        title=f"Маршрут {body.groupType or 'solo'}",
        status="draft",
        params=params,
    )
    db.add(route)
    await db.commit()
    await db.refresh(route)

    builder = RouteBuilder(route.id, params)
    request.app.state.scheduler.run_once(
        f"route_build_{route.id}",
        builder.run,
    )

    return RouteBuildResponse(routeId=route.id, status="draft")


@router.get(
    "/{route_id}/status",
    response_model=RouteStatusResponse,
    summary="Статус построения маршрута (long-poll)",
)
async def get_route_status(
    route_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    return RouteStatusResponse(
        routeId=route.id,
        status=route.status.value if hasattr(route.status, "value") else str(route.status),
        title=route.title,
        narrative=route.narrative,
        totalExperiences=route.total_experiences or 0,
    )


@router.get(
    "/{route_id}/full",
    summary="Полный маршрут, сгруппированный по типам",
)
async def get_route_full(
    route_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    return await _build_full_response(route, db)


@router.get(
    "/{route_id}/pins",
    summary="Пины маршрута (карта)",
)
async def get_route_pins(
    route_id: int,
    zoom_level: Optional[int] = None,
    segment_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    filters = [RoutePin.route_id == route_id]
    if zoom_level is not None:
        filters.append(RoutePin.zoom_level == zoom_level)
    if segment_id is not None:
        filters.append(RoutePin.segment_id == segment_id)

    result = await db.execute(
        select(RoutePin).where(and_(*filters)).order_by(RoutePin.position)
    )
    pins = result.scalars().all()

    return [
        {
            "id": pin.id,
            "label": pin.label,
            "pinType": pin.pin_type.value if hasattr(pin.pin_type, "value") else str(pin.pin_type),
            "lat": pin.lat,
            "lng": pin.lng,
            "icon": pin.icon,
            "color": pin.color,
            "position": pin.position,
            "zoomLevel": pin.zoom_level,
            "isVisible": pin.is_visible,
            "source": pin.source.value if hasattr(pin.source, "value") else str(pin.source),
            "notes": pin.notes,
        }
        for pin in pins
    ]


@router.get(
    "/share/{share_token}",
    summary="Публичный просмотр маршрута по share-токену (без авторизации)",
)
async def get_route_by_share_token(
    share_token: str,
    db: AsyncSession = Depends(get_db_session),
):
    result = await db.execute(
        select(Route).where(Route.share_token == share_token)
    )
    route = result.scalar_one_or_none()
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    return await _build_full_response(route, db)


@router.post(
    "/{route_id}/book",
    status_code=status.HTTP_201_CREATED,
    summary="Забронировать маршрут",
)
async def book_route(
    route_id: int,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    booking = Booking(
        route_id=route.id,
        user_id=user.id,
        status="pending",
        total_price=route.total_price,
        currency="RUB",
    )
    db.add(booking)
    await db.commit()
    await db.refresh(booking)

    return {"bookingId": booking.id, "status": booking.status.value}


@router.post(
    "/{route_id}/refresh-prices",
    summary="Запустить обновление цен маршрута",
)
async def refresh_route_prices(
    route_id: int,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    route.total_price_status = "stale"
    await db.commit()

    return {"status": "refreshing"}


@router.put(
    "/{route_id}/pins",
    status_code=status.HTTP_201_CREATED,
    summary="Добавить пользовательский пин на маршрут",
)
async def create_route_pin(
    route_id: int,
    body: CreatePinRequest,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    try:
        pin_type_value = PinType(body.pinType)
    except ValueError:
        raise HTTPException(status_code=422, detail=f"Invalid pinType: {body.pinType}")

    pin = RoutePin(
        route_id=route.id,
        label=body.label,
        pin_type=pin_type_value,
        lat=body.lat,
        lng=body.lng,
        icon=body.icon,
        color=body.color,
        notes=body.notes,
        source=PinSource.user,
        created_by=user.id,
    )
    db.add(pin)
    await db.commit()
    await db.refresh(pin)

    return {
        "id": pin.id,
        "label": pin.label,
        "pinType": pin.pin_type.value,
        "lat": pin.lat,
        "lng": pin.lng,
        "icon": pin.icon,
        "color": pin.color,
        "position": pin.position,
        "zoomLevel": pin.zoom_level,
        "isVisible": pin.is_visible,
        "source": pin.source.value,
        "notes": pin.notes,
    }


@router.delete(
    "/{route_id}/pins/{pin_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить пользовательский пин",
)
async def delete_route_pin(
    route_id: int,
    pin_id: int,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    result = await db.execute(
        select(RoutePin).where(
            and_(RoutePin.id == pin_id, RoutePin.route_id == route_id)
        )
    )
    pin = result.scalar_one_or_none()
    if not pin:
        raise HTTPException(status_code=404, detail="Pin not found")

    pin_source = pin.source.value if hasattr(pin.source, "value") else str(pin.source)
    if pin_source != "user" and pin.created_by != user.id:
        raise HTTPException(status_code=403, detail="Cannot delete this pin")

    await db.delete(pin)
    await db.commit()
