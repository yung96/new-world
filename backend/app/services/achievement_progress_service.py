from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone

from sqlalchemy import and_, func, select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.achievement import Achievement
from app.models.associations import post_interests, user_achievements
from app.models.interest import Interest
from app.models.review import Review


@dataclass(frozen=True)
class AchievementProgressRow:
    achievement_id: int
    name: str
    description: str | None
    interest_id: int
    interest_name: str
    required_distinct_posts: int
    current_count: int
    unlocked: bool
    earned_at: datetime | None


class AchievementProgressService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def count_distinct_posts_reviewed(self, *, user_id: int, interest_id: int) -> int:
        stmt = (
            select(func.count(func.distinct(Review.post_id)))
            .select_from(Review)
            .join(
                post_interests,
                and_(
                    post_interests.c.post_id == Review.post_id,
                    post_interests.c.interest_id == interest_id,
                ),
            )
            .where(Review.author_id == user_id)
        )
        return int((await self.db.execute(stmt)).scalar_one() or 0)

    async def evaluate_and_grant_after_review(self, *, user_id: int, post_id: int) -> None:
        i_stmt = select(post_interests.c.interest_id).where(post_interests.c.post_id == post_id)
        interest_ids = [int(x) for x in (await self.db.execute(i_stmt)).scalars().all()]
        if not interest_ids:
            return

        stmt = select(Achievement).where(
            Achievement.interest_id.in_(interest_ids),
            Achievement.required_distinct_posts.isnot(None),
        )
        rules = (await self.db.execute(stmt)).scalars().all()
        for ach in rules:
            assert ach.interest_id is not None and ach.required_distinct_posts is not None
            has = (
                await self.db.execute(
                    select(user_achievements.c.user_id).where(
                        user_achievements.c.user_id == user_id,
                        user_achievements.c.achievement_id == ach.id,
                    )
                )
            ).first()
            if has is not None:
                continue
            cnt = await self.count_distinct_posts_reviewed(
                user_id=user_id, interest_id=ach.interest_id
            )
            if cnt >= ach.required_distinct_posts:
                await self.db.execute(
                    user_achievements.insert().values(
                        user_id=user_id,
                        achievement_id=ach.id,
                        earned_at=datetime.now(timezone.utc),
                    )
                )

    async def list_progress(self, *, user_id: int) -> list[AchievementProgressRow]:
        stmt = (
            select(Achievement, Interest)
            .join(Interest, Interest.id == Achievement.interest_id)
            .where(
                Achievement.interest_id.isnot(None),
                Achievement.required_distinct_posts.isnot(None),
            )
            .order_by(Achievement.id.asc())
        )
        rows = (await self.db.execute(stmt)).all()
        out: list[AchievementProgressRow] = []
        for ach, interest in rows:
            assert ach.required_distinct_posts is not None
            earned_row = (
                await self.db.execute(
                    select(user_achievements.c.earned_at).where(
                        user_achievements.c.user_id == user_id,
                        user_achievements.c.achievement_id == ach.id,
                    )
                )
            ).first()
            cnt = await self.count_distinct_posts_reviewed(
                user_id=user_id, interest_id=interest.id
            )
            earned_at = earned_row[0] if earned_row is not None else None
            out.append(
                AchievementProgressRow(
                    achievement_id=ach.id,
                    name=ach.name,
                    description=ach.description,
                    interest_id=interest.id,
                    interest_name=interest.name,
                    required_distinct_posts=ach.required_distinct_posts,
                    current_count=cnt,
                    unlocked=earned_at is not None,
                    earned_at=earned_at,
                )
            )
        return out
