from __future__ import annotations

from fastapi import HTTPException, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.interest import Interest
from app.models.post import Post, Season
from app.models.review import Review
from app.models.user import User


class PostService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_post(
        self,
        *,
        author: User,
        title: str,
        description: str | None,
        geo_lat: float | None,
        geo_lng: float | None,
        media_urls: list[str],
        tags: list[str],
        season: Season,
        interest_ids: list[int],
    ) -> Post:
        interests = await self._load_interests(interest_ids)
        post = Post(
            author_id=author.id,
            title=title.strip(),
            description=description,
            geo_lat=geo_lat,
            geo_lng=geo_lng,
            media_urls=media_urls,
            tags=tags,
            season=season,
            interests=interests,
        )
        self.db.add(post)
        await self.db.commit()
        await self.db.refresh(post)
        return post

    async def list_posts(self, *, page: int, page_size: int) -> tuple[list[tuple[Post, float | None]], int]:
        offset = (page - 1) * page_size
        total_stmt = select(func.count(Post.id))
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
            .options(selectinload(Post.author), selectinload(Post.interests))
            .order_by(Post.created_at.desc(), Post.id.desc())
            .offset(offset)
            .limit(page_size)
        )
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
            .options(selectinload(Post.author), selectinload(Post.interests))
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
        media_urls: list[str] | None = None,
        tags: list[str] | None = None,
        season: Season | None = None,
        interest_ids: list[int] | None = None,
    ) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only author can update post")

        if title is not None:
            post.title = title.strip()
        if description is not None:
            post.description = description
        if geo_lat is not None:
            post.geo_lat = geo_lat
        if geo_lng is not None:
            post.geo_lng = geo_lng
        if media_urls is not None:
            post.media_urls = media_urls
        if tags is not None:
            post.tags = tags
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
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only author can delete post")
        await self.db.delete(post)
        await self.db.commit()

    async def add_interest(self, *, actor: User, post_id: int, interest_id: int) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only author can edit interests")
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        if interest not in post.interests:
            post.interests.append(interest)
            await self.db.commit()
        updated_post, _ = await self.get_post_or_404(post.id)
        return updated_post

    async def remove_interest(self, *, actor: User, post_id: int, interest_id: int) -> Post:
        post, _ = await self.get_post_or_404(post_id)
        if post.author_id != actor.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only author can edit interests")
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
