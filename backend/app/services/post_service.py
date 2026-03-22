from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.associations import UserPlaceStatus
from app.models.interest import Interest
from app.models.post import Post, Season
from app.models.review import Review
from app.models.user import User
from app.services.social_service import SocialService


class PostService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_post(
        self,
        *,
        author: User,
        title: str,
        city: str | None = None,
        description: str | None,
        geo_lat: float | None,
        geo_lng: float | None,
        season: Season,
        interest_ids: list[int],
    ) -> Post:
        interests = await self._load_interests(interest_ids)
        post = Post(
            author_id=author.id,
            title=title.strip(),
            city=city.strip() if city else None,
            description=description,
            geo_lat=geo_lat,
            geo_lng=geo_lng,
            season=season,
            interests=interests,
        )
        self.db.add(post)
        await self.db.commit()
        await self.db.refresh(post)
        return post

    async def list_posts(
        self,
        *,
        page: int,
        page_size: int,
        search: str | None = None,
        city: str | None = None,
        season: Season | None = None,
        region_id: int | None = None,
    ) -> tuple[list[tuple[Post, float | None]], int]:
        offset = (page - 1) * page_size

        filters = []
        if search:
            filters.append(Post.title.ilike(f"%{search}%"))
        if city:
            filters.append(Post.city.ilike(f"%{city}%"))
        if season:
            filters.append(Post.season == season)
        if region_id:
            filters.append(Post.region_id == region_id)

        total_stmt = select(func.count(Post.id))
        if filters:
            total_stmt = total_stmt.where(*filters)
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)

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
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .options(selectinload(Post.interests), selectinload(Post.media))
            .order_by(Post.created_at.desc(), Post.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        if filters:
            stmt = stmt.where(*filters)
        rows = (await self.db.execute(stmt)).all()
        return rows, total

    async def get_post_or_404(self, post_id: int) -> tuple[Post, float | None]:
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
            .where(Post.id == post_id)
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .options(selectinload(Post.interests), selectinload(Post.media))
            .limit(1)
        )
        row = (await self.db.execute(stmt)).first()
        if row is None:
            raise HTTPException(status_code=404, detail="Post not found")
        return row

    async def update_post(
        self,
        *,
        actor: User,
        post_id: int,
        title: str | None = None,
        description: str | None = None,
        geo_lat: float | None = None,
        geo_lng: float | None = None,
        season: Season | None = None,
        interest_ids: list[int] | None = None,
    ) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Only author can update post",
            )

        if title is not None:
            post.title = title.strip()
        if description is not None:
            post.description = description
        if geo_lat is not None:
            post.geo_lat = geo_lat
        if geo_lng is not None:
            post.geo_lng = geo_lng
        if season is not None:
            post.season = season
        if interest_ids is not None:
            post.interests = await self._load_interests(interest_ids)

        await self.db.commit()
        await self.db.refresh(post)
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def delete_post(self, *, actor: User, post_id: int) -> None:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Only author can delete post",
            )
        await self.db.delete(post)
        await self.db.commit()

    async def admin_update_post(
        self,
        *,
        post_id: int,
        title: str | None = None,
        region_id: int | None = None,
        city: str | None = None,
        description: str | None = None,
        geo_lat: float | None = None,
        geo_lng: float | None = None,
        season: Season | None = None,
        interest_ids: list[int] | None = None,
    ) -> Post:
        post, _ = await self.get_post_or_404(post_id)

        if title is not None:
            post.title = title.strip()
        if region_id is not None:
            post.region_id = region_id
        if city is not None:
            post.city = city.strip() if city else None
        if description is not None:
            post.description = description
        if geo_lat is not None:
            post.geo_lat = geo_lat
        if geo_lng is not None:
            post.geo_lng = geo_lng
        if season is not None:
            post.season = season
        if interest_ids is not None:
            post.interests = await self._load_interests(interest_ids)

        await self.db.commit()
        await self.db.refresh(post)
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def admin_delete_post(self, *, post_id: int) -> None:
        post, _ = await self.get_post_or_404(post_id)
        await self.db.delete(post)
        await self.db.commit()

    async def admin_add_interest(self, *, post_id: int, interest_id: int) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        if interest not in post.interests:
            post.interests.append(interest)
            await self.db.commit()
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def admin_remove_interest(self, *, post_id: int, interest_id: int) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        post.interests = [i for i in post.interests if i.id != interest_id]
        await self.db.commit()
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def add_interest(
        self, *, actor: User, post_id: int, interest_id: int
    ) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Only author can edit interests",
            )
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        if interest not in post.interests:
            post.interests.append(interest)
            await self.db.commit()
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def remove_interest(
        self, *, actor: User, post_id: int, interest_id: int
    ) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Only author can edit interests",
            )
        post.interests = [i for i in post.interests if i.id != interest_id]
        await self.db.commit()
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def _load_interests(self, interest_ids: list[int]) -> list[Interest]:
        if not interest_ids:
            return []
        unique_ids = sorted(set(int(i) for i in interest_ids))
        stmt = select(Interest).where(Interest.id.in_(unique_ids))
        interests = (await self.db.execute(stmt)).scalars().all()
        if len(interests) != len(unique_ids):
            raise HTTPException(status_code=404, detail="Some interests not found")
        return interests

    async def add_favorite(self, *, user: User, post_id: int) -> None:
        await self.get_post_or_404(post_id)
        exists_stmt = select(UserPlaceStatus).where(
            UserPlaceStatus.user_id == user.id,
            UserPlaceStatus.post_id == post_id,
        )
        exists = (await self.db.execute(exists_stmt)).first() is not None
        if not exists:
            self.db.add(
                UserPlaceStatus(user_id=user.id, post_id=post_id, status="want")
            )
            # веса — один раз на пару (user, post): повторный add_favorite не вызывается
            await SocialService(self.db).apply_post_engagement_weights(
                user=user, post_id=post_id, source="favorite"
            )
            await self.db.commit()

    async def remove_favorite(self, *, user: User, post_id: int) -> None:
        existing_stmt = select(UserPlaceStatus).where(
            UserPlaceStatus.user_id == user.id,
            UserPlaceStatus.post_id == post_id,
        )
        row = (await self.db.execute(existing_stmt)).scalar_one_or_none()
        if row is not None:
            await self.db.delete(row)
            await self.db.commit()

    async def list_favorites(
        self, *, user: User, page: int, page_size: int
    ) -> tuple[list[tuple[Post, float | None]], int]:
        offset = (page - 1) * page_size
        total_stmt = (
            select(func.count())
            .select_from(UserPlaceStatus)
            .where(UserPlaceStatus.user_id == user.id)
        )
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)

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
            .join(UserPlaceStatus, UserPlaceStatus.post_id == Post.id)
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .where(UserPlaceStatus.user_id == user.id)
            .options(selectinload(Post.interests), selectinload(Post.media))
            .order_by(Post.created_at.desc(), Post.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        rows = (await self.db.execute(stmt)).all()
        return rows, total
