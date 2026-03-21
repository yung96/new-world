from __future__ import annotations

from enum import StrEnum

from fastapi import HTTPException
from sqlalchemy import func, select
from sqlalchemy.dialects.postgresql import insert
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.associations import user_swiped_posts
from app.models.post import Post
from app.models.user import User
from app.services.feed_service import FeedService
from app.services.post_service import PostService


class SwipeDirection(StrEnum):
    left = "left"
    right = "right"


class SwipeService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_next_card(self, *, user: User) -> tuple[tuple[Post, float | None] | None, int]:
        swiped_ids = await self._swiped_post_ids(user.id)
        rows, total_available = await FeedService(self.db).list_feed(
            user=user,
            page=1,
            page_size=1,
            exclude_post_ids=swiped_ids,
        )
        if not rows:
            return None, total_available
        return rows[0], total_available

    async def swipe(
        self,
        *,
        user: User,
        post_id: int,
        direction: SwipeDirection,
    ) -> bool:
        post_exists_stmt = select(Post.id).where(Post.id == post_id).limit(1)
        post_exists = (await self.db.execute(post_exists_stmt)).scalar_one_or_none()
        if post_exists is None:
            raise HTTPException(status_code=404, detail="Post not found")

        stmt = (
            insert(user_swiped_posts)
            .values(user_id=user.id, post_id=post_id, direction=direction.value)
            .on_conflict_do_nothing(
                index_elements=[user_swiped_posts.c.user_id, user_swiped_posts.c.post_id]
            )
        )
        result = await self.db.execute(stmt)
        inserted = bool(result.rowcount)

        if inserted and direction is SwipeDirection.right:
            await PostService(self.db).add_favorite(user=user, post_id=post_id)
        else:
            await self.db.commit()

        return inserted

    async def _swiped_post_ids(self, user_id: int) -> set[int]:
        stmt = select(user_swiped_posts.c.post_id).where(user_swiped_posts.c.user_id == user_id)
        rows = (await self.db.execute(stmt)).scalars().all()
        return {int(pid) for pid in rows}

    async def count_available_cards(self, *, user: User) -> int:
        swiped_ids = await self._swiped_post_ids(user.id)
        stmt = select(func.count(Post.id))
        if swiped_ids:
            stmt = stmt.where(Post.id.not_in(swiped_ids))
        return int((await self.db.execute(stmt)).scalar_one() or 0)
