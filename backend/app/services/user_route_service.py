from __future__ import annotations

from typing import Any

from fastapi import HTTPException, status
from sqlalchemy import delete, func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.post import Post
from app.models.review import Review
from app.models.user import User
from app.models.user_saved_route import UserSavedRoute, UserSavedRouteItem

UNSET: Any = object()


class UserRouteService:
    def __init__(self, db: AsyncSession):
        self.db = db

    def _assert_unique_post_chain(self, post_ids: list[int]) -> None:
        if len(post_ids) != len(set(post_ids)):
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="Цепочка не должна содержать одно и то же место дважды.",
            )

    async def _assert_posts_exist(self, post_ids: list[int]) -> None:
        if not post_ids:
            return
        cnt_stmt = select(func.count(Post.id)).where(Post.id.in_(post_ids))
        found = int((await self.db.execute(cnt_stmt)).scalar_one() or 0)
        if found != len(post_ids):
            raise HTTPException(status_code=404, detail="Одно или несколько мест не найдены")

    async def create_route(
        self,
        *,
        user: User,
        title: str | None,
        start_lat: float,
        start_lng: float,
        start_label: str | None,
        post_ids: list[int],
    ) -> UserSavedRoute:
        self._assert_unique_post_chain(post_ids)
        await self._assert_posts_exist(post_ids)

        route = UserSavedRoute(
            user_id=user.id,
            title=title.strip() if title else None,
            start_lat=start_lat,
            start_lng=start_lng,
            start_label=start_label.strip() if start_label else None,
            ai_generated=False,
            ai_route_meta=None,
        )
        self.db.add(route)
        await self.db.flush()
        for pos, pid in enumerate(post_ids):
            self.db.add(UserSavedRouteItem(route_id=route.id, post_id=pid, position=pos))
        await self.db.commit()
        await self.db.refresh(route)
        return route

    async def create_ai_route(
        self,
        *,
        user: User,
        title: str | None,
        start_lat: float,
        start_lng: float,
        start_label: str | None,
        post_ids: list[int],
        ai_route_meta: dict,
    ) -> UserSavedRoute:
        self._assert_unique_post_chain(post_ids)
        await self._assert_posts_exist(post_ids)

        route = UserSavedRoute(
            user_id=user.id,
            title=title.strip() if title else None,
            start_lat=start_lat,
            start_lng=start_lng,
            start_label=start_label.strip() if start_label else None,
            ai_generated=True,
            ai_route_meta=ai_route_meta,
        )
        self.db.add(route)
        await self.db.flush()
        for pos, pid in enumerate(post_ids):
            self.db.add(UserSavedRouteItem(route_id=route.id, post_id=pid, position=pos))
        await self.db.commit()
        await self.db.refresh(route)
        return route

    async def list_routes(
        self, *, user: User, page: int, page_size: int
    ) -> tuple[list[UserSavedRoute], int]:
        offset = (page - 1) * page_size
        total_stmt = select(func.count(UserSavedRoute.id)).where(UserSavedRoute.user_id == user.id)
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)

        stmt = (
            select(UserSavedRoute)
            .where(UserSavedRoute.user_id == user.id)
            .options(
                selectinload(UserSavedRoute.items).selectinload(UserSavedRouteItem.post)
            )
            .order_by(UserSavedRoute.updated_at.desc(), UserSavedRoute.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        routes = list((await self.db.execute(stmt)).scalars().all())
        return routes, total

    async def get_route_owned(self, *, user_id: int, route_id: int) -> UserSavedRoute:
        stmt = (
            select(UserSavedRoute)
            .where(UserSavedRoute.id == route_id, UserSavedRoute.user_id == user_id)
            .options(selectinload(UserSavedRoute.items).selectinload(UserSavedRouteItem.post))
            .limit(1)
        )
        route = (await self.db.execute(stmt)).scalar_one_or_none()
        if route is None:
            raise HTTPException(status_code=404, detail="Маршрут не найден")
        return route

    async def delete_route(self, *, user_id: int, route_id: int) -> None:
        stmt = delete(UserSavedRoute).where(
            UserSavedRoute.id == route_id,
            UserSavedRoute.user_id == user_id,
        )
        res = await self.db.execute(stmt)
        await self.db.commit()
        if res.rowcount == 0:
            raise HTTPException(status_code=404, detail="Маршрут не найден")

    async def update_route(
        self,
        *,
        user: User,
        route_id: int,
        title: str | None | Any = UNSET,
        start_lat: float | Any = UNSET,
        start_lng: float | Any = UNSET,
        start_label: str | None | Any = UNSET,
        post_ids: list[int] | Any = UNSET,
    ) -> UserSavedRoute:
        route = await self.get_route_owned(user_id=user.id, route_id=route_id)

        if title is not UNSET:
            route.title = title.strip() if title else None

        geo_partial = (start_lat is not UNSET) ^ (start_lng is not UNSET)
        if geo_partial:
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="Укажите и startLat, и startLng при смене координат точки А.",
            )
        if start_lat is not UNSET and start_lng is not UNSET:
            route.start_lat = start_lat
            route.start_lng = start_lng
        if start_label is not UNSET:
            route.start_label = start_label.strip() if start_label else None

        if post_ids is not UNSET:
            ids = list(post_ids) if post_ids is not None else []
            self._assert_unique_post_chain(ids)
            await self._assert_posts_exist(ids)
            await self.db.execute(
                delete(UserSavedRouteItem).where(UserSavedRouteItem.route_id == route_id)
            )
            for pos, pid in enumerate(ids):
                self.db.add(UserSavedRouteItem(route_id=route_id, post_id=pid, position=pos))

        await self.db.commit()
        self.db.expire_all()
        stmt = (
            select(UserSavedRoute)
            .where(UserSavedRoute.id == route_id)
            .options(selectinload(UserSavedRoute.items).selectinload(UserSavedRouteItem.post))
        )
        return (await self.db.execute(stmt)).scalar_one()

    async def posts_with_ratings_ordered(self, post_ids: list[int]) -> list[tuple[Post, float | None]]:
        if not post_ids:
            return []
        rating_subquery = (
            select(
                Review.post_id.label("post_id"),
                func.avg(Review.rating).label("avg_rating"),
            )
            .group_by(Review.post_id)
            .subquery()
        )
        stmt = (
            select(Post, rating_subquery.c.avg_rating)
            .where(Post.id.in_(post_ids))
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .options(selectinload(Post.interests))
        )
        rows = (await self.db.execute(stmt)).all()
        by_id = {p.id: (p, avg) for p, avg in rows}
        missing = [pid for pid in post_ids if pid not in by_id]
        if missing:
            raise HTTPException(status_code=404, detail="Одно или несколько мест не найдены")
        return [by_id[pid] for pid in post_ids]
