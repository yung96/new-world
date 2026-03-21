from __future__ import annotations

from typing import Literal

from fastapi import HTTPException, status
from sqlalchemy import and_, func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.achievement import Achievement
from app.models.associations import user_achievements, user_interests, user_subscriptions
from app.models.interest import Interest
from app.models.post import Post
from app.models.user import User

# Веса по взаимодействию с карточкой (постом)
# Плюс за действие — заметный; пассивный минус по «лишним» интересам — небольшой.
MIN_INTEREST_WEIGHT = 1
BONUS_INTEREST_WEIGHT_FAVORITE = 20
BONUS_INTEREST_WEIGHT_REVIEW = 30
PASSIVE_INTEREST_WEIGHT_DECAY = 1

PostEngagementSource = Literal["favorite", "review"]


class SocialService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_user_or_404(self, user_id: int) -> User:
        user = await self.db.get(User, user_id)
        if user is None:
            raise HTTPException(status_code=404, detail="User not found")
        return user

    async def create_interest(self, name: str, emoji: str | None = None) -> Interest:
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Interest name is required")
        normalized_emoji = (emoji or "").strip() or "🪁"
        exists = (
            await self.db.execute(select(Interest).where(Interest.name == normalized))
        ).scalar_one_or_none()
        if exists is not None:
            return exists
        interest = Interest(name=normalized, emoji=normalized_emoji)
        self.db.add(interest)
        await self.db.commit()
        await self.db.refresh(interest)
        return interest

    async def list_interests(
        self, *, page: int, page_size: int
    ) -> tuple[list[Interest], int]:
        offset = (page - 1) * page_size
        total = int(
            (await self.db.execute(select(func.count(Interest.id)))).scalar_one() or 0
        )
        items = (
            (
                await self.db.execute(
                    select(Interest)
                    .order_by(Interest.name.asc())
                    .offset(offset)
                    .limit(page_size)
                )
            )
            .scalars()
            .all()
        )
        return items, total

    async def delete_interest(self, interest_id: int) -> None:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        await self.db.delete(interest)
        await self.db.commit()

    async def update_interest(self, *, interest_id: int, name: str) -> Interest:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Interest name is required")
        duplicate = (
            await self.db.execute(
                select(Interest).where(
                    Interest.name == normalized, Interest.id != interest_id
                )
            )
        ).scalar_one_or_none()
        if duplicate is not None:
            raise HTTPException(
                status_code=409, detail="Interest with this name already exists"
            )
        interest.name = normalized
        await self.db.commit()
        await self.db.refresh(interest)
        return interest

    async def add_interest_to_user(self, *, user: User, interest_id: int) -> User:
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        exists_stmt = select(user_interests.c.user_id).where(
            user_interests.c.user_id == user.id,
            user_interests.c.interest_id == interest_id,
        )
        exists = (await self.db.execute(exists_stmt)).first() is not None
        if not exists:
            await self.db.execute(
                user_interests.insert().values(user_id=user.id, interest_id=interest_id)
            )
            await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def get_interests_by_user(self, user_id: int) -> list[Interest]:
        stmt = (
            select(Interest)
            .join(
                user_interests,
                user_interests.c.interest_id == Interest.id,
            )
            .where(user_interests.c.user_id == user_id)
            .order_by(user_interests.c.weight.desc())
        )

        result = await self.db.execute(stmt)
        return result.scalars().all()

    async def add_interests_to_user(
        self,
        *,
        user: User,
        interest_ids: list[int],
    ) -> User:
        if not interest_ids:
            return user

        stmt = select(Interest.id).where(Interest.id.in_(interest_ids))
        result = await self.db.execute(stmt)
        existing_ids = {row[0] for row in result.fetchall()}

        if not existing_ids:
            raise HTTPException(status_code=404, detail="Interests not found")

        exists_stmt = select(user_interests.c.interest_id).where(
            user_interests.c.user_id == user.id,
            user_interests.c.interest_id.in_(existing_ids),
        )
        result = await self.db.execute(exists_stmt)
        already_added = {row[0] for row in result.fetchall()}

        to_insert = existing_ids - already_added

        if to_insert:
            await self.db.execute(
                user_interests.insert(),
                [{"user_id": user.id, "interest_id": i} for i in to_insert],
            )
            await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def remove_interest_from_user(self, *, user: User, interest_id: int) -> User:
        await self.db.execute(
            user_interests.delete().where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest_id,
            )
        )
        await self.db.commit()
        user = await self.get_user_or_404(user.id)
        return user

    async def set_interest_weight_for_user(
        self, *, user: User, interest_id: int, weight: int
    ) -> None:
        stmt = (
            user_interests.update()
            .where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest_id,
            )
            .values(weight=weight)
        )
        result = await self.db.execute(stmt)
        if result.rowcount == 0:
            interest = await self.db.get(Interest, interest_id)
            if interest is None:
                raise HTTPException(status_code=404, detail="Interest not found")
            raise HTTPException(status_code=404, detail="Interest is not bound to user")
        await self.db.commit()

    async def get_interest_weights_for_user(self, *, user: User) -> dict[int, int]:
        stmt = select(user_interests.c.interest_id, user_interests.c.weight).where(
            user_interests.c.user_id == user.id
        )
        rows = (await self.db.execute(stmt)).all()
        return {row.interest_id: row.weight for row in rows}

    async def apply_post_engagement_weights(
        self,
        *,
        user: User,
        post_id: int,
        source: PostEngagementSource,
    ) -> None:
        """Корректирует веса интересов пользователя после отзыва или добавления в избранное.

        Ожидается не более одного срабатывания на пару (пользователь, пост) на тип события:
        избранное вызывает только при первом добавлении, отзыв — только при первом отзыве
        этого пользователя на пост (см. ReviewService).

        Не вызывает commit — вызывающий код фиксирует транзакцию.
        """
        bonus = (
            BONUS_INTEREST_WEIGHT_FAVORITE
            if source == "favorite"
            else BONUS_INTEREST_WEIGHT_REVIEW
        )

        stmt = (
            select(Post)
            .where(Post.id == post_id)
            .options(selectinload(Post.interests))
            .limit(1)
        )
        post = (await self.db.execute(stmt)).scalar_one_or_none()
        if post is None:
            raise HTTPException(status_code=404, detail="Post not found")

        post_interest_ids = {i.id for i in post.interests}

        decay_conditions = [user_interests.c.user_id == user.id]
        if post_interest_ids:
            decay_conditions.append(
                user_interests.c.interest_id.not_in(post_interest_ids)
            )
        await self.db.execute(
            user_interests.update()
            .where(and_(*decay_conditions))
            .values(
                weight=func.greatest(
                    MIN_INTEREST_WEIGHT,
                    user_interests.c.weight - PASSIVE_INTEREST_WEIGHT_DECAY,
                )
            )
        )

        for interest_id in post_interest_ids:
            exists_stmt = select(user_interests.c.weight).where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest_id,
            )
            row = (await self.db.execute(exists_stmt)).first()
            if row is not None:
                await self.db.execute(
                    user_interests.update()
                    .where(
                        user_interests.c.user_id == user.id,
                        user_interests.c.interest_id == interest_id,
                    )
                    .values(weight=user_interests.c.weight + bonus)
                )
            else:
                new_weight = max(MIN_INTEREST_WEIGHT, MIN_INTEREST_WEIGHT + bonus)
                await self.db.execute(
                    user_interests.insert().values(
                        user_id=user.id,
                        interest_id=interest_id,
                        weight=new_weight,
                    )
                )

    async def create_rule_achievement(
        self,
        *,
        name: str,
        description: str | None,
        interest_id: int,
        required_distinct_posts: int,
    ) -> Achievement:
        if required_distinct_posts < 1:
            raise HTTPException(
                status_code=400, detail="required_distinct_posts must be at least 1"
            )
        interest = await self.db.get(Interest, interest_id)
        if interest is None:
            raise HTTPException(status_code=404, detail="Interest not found")
        normalized = (name or "").strip()
        if not normalized:
            raise HTTPException(status_code=400, detail="Achievement name is required")
        dup = (
            await self.db.execute(
                select(Achievement).where(Achievement.name == normalized)
            )
        ).scalar_one_or_none()
        if dup is not None:
            raise HTTPException(
                status_code=409, detail="Achievement with this name already exists"
            )
        achievement = Achievement(
            name=normalized,
            description=description,
            interest_id=interest_id,
            required_distinct_posts=required_distinct_posts,
        )
        self.db.add(achievement)
        await self.db.commit()
        stmt = (
            select(Achievement)
            .options(selectinload(Achievement.interest))
            .where(Achievement.id == achievement.id)
        )
        loaded = (await self.db.execute(stmt)).scalar_one()
        return loaded

    async def list_achievements(
        self, *, page: int, page_size: int
    ) -> tuple[list[Achievement], int]:
        offset = (page - 1) * page_size
        total = int(
            (await self.db.execute(select(func.count(Achievement.id)))).scalar_one()
            or 0
        )
        stmt = (
            select(Achievement)
            .options(selectinload(Achievement.interest))
            .order_by(Achievement.id.asc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def delete_achievement(self, achievement_id: int) -> None:
        achievement = await self.db.get(Achievement, achievement_id)
        if achievement is None:
            raise HTTPException(status_code=404, detail="Achievement not found")
        await self.db.delete(achievement)
        await self.db.commit()

    async def subscribe(self, *, subscriber: User, following_id: int) -> None:
        if subscriber.id == following_id:
            raise HTTPException(status_code=400, detail="Cannot subscribe to yourself")
        await self.get_user_or_404(following_id)
        exists_stmt = select(user_subscriptions.c.subscriber_id).where(
            user_subscriptions.c.subscriber_id == subscriber.id,
            user_subscriptions.c.following_id == following_id,
        )
        exists = (await self.db.execute(exists_stmt)).first() is not None
        if exists:
            raise HTTPException(status_code=409, detail="Already subscribed")
        await self.db.execute(
            user_subscriptions.insert().values(
                subscriber_id=subscriber.id,
                following_id=following_id,
            )
        )
        await self.db.commit()

    async def unsubscribe(self, *, subscriber: User, following_id: int) -> None:
        await self.db.execute(
            user_subscriptions.delete().where(
                user_subscriptions.c.subscriber_id == subscriber.id,
                user_subscriptions.c.following_id == following_id,
            )
        )
        await self.db.commit()

    async def list_following(
        self, user: User, *, page: int, page_size: int
    ) -> tuple[list[User], int]:
        offset = (page - 1) * page_size
        total_stmt = (
            select(func.count())
            .select_from(user_subscriptions)
            .where(user_subscriptions.c.subscriber_id == user.id)
        )
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(User)
            .join(user_subscriptions, user_subscriptions.c.following_id == User.id)
            .where(user_subscriptions.c.subscriber_id == user.id)
            .order_by(User.id.asc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def count_followers(self, *, user_id: int) -> int:
        stmt = (
            select(func.count())
            .select_from(user_subscriptions)
            .where(user_subscriptions.c.following_id == user_id)
        )
        return int((await self.db.execute(stmt)).scalar_one() or 0)
