from __future__ import annotations

from datetime import date

from fastapi import APIRouter, Depends, HTTPException, Request, status
from pydantic import BaseModel, Field
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.route import Route, RouteSegment, SegmentItem
from app.models.user import User
from app.services.pipeline import RouteBuilder

router = APIRouter(prefix="/routes")


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

    # Fire pipeline in background
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
        status=route.status.value if hasattr(route.status, 'value') else str(route.status),
        title=route.title,
        narrative=route.narrative,
        totalExperiences=route.total_experiences or 0,
    )


@router.get(
    "/{route_id}/full",
    summary="Полный маршрут с точками",
)
async def get_route_full(
    route_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    route = await db.get(Route, route_id)
    if not route:
        raise HTTPException(status_code=404, detail="Route not found")

    segments = (await db.execute(
        select(RouteSegment)
        .where(RouteSegment.route_id == route_id)
        .order_by(RouteSegment.position)
    )).scalars().all()

    result = {
        "routeId": route.id,
        "status": route.status.value if hasattr(route.status, 'value') else str(route.status),
        "title": route.title,
        "narrative": route.narrative,
        "params": route.params,
        "totalExperiences": route.total_experiences,
        "segments": [],
    }

    for seg in segments:
        items = (await db.execute(
            select(SegmentItem)
            .where(SegmentItem.segment_id == seg.id)
            .order_by(SegmentItem.position)
        )).scalars().all()

        import json
        seg_data = {
            "id": seg.id,
            "title": seg.title,
            "items": [
                {
                    "id": item.id,
                    "type": str(item.type),
                    "position": item.position,
                    "parentId": item.parent_id,
                    "details": json.loads(item.details) if item.details else None,
                    "aiComment": item.ai_comment,
                }
                for item in items
            ],
        }
        result["segments"].append(seg_data)

    return result
