from fastapi import HTTPException, status
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.post import Post
from app.models.review import Review
from app.models.user import User
from app.services.achievement_progress_service import AchievementProgressService
from app.services.social_service import SocialService


class ReviewService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def create_review(
        self,
        *,
        author: User,
        post_id: int,
        rating: int,
        comment: str | None,
        media_urls: list[str],
    ) -> Review:
        post = await self.db.get(Post, post_id)
        if post is None:
            raise HTTPException(status_code=404, detail="Post not found")

        prior_count_stmt = select(func.count(Review.id)).where(
            Review.author_id == author.id,
            Review.post_id == post_id,
        )
        prior_reviews = int(
            (await self.db.execute(prior_count_stmt)).scalar_one() or 0
        )
        first_review_on_post = prior_reviews == 0

        review = Review(
            author_id=author.id,
            post_id=post_id,
            rating=rating,
            comment=comment,
            media_urls=media_urls,
        )
        self.db.add(review)
        if first_review_on_post:
            await SocialService(self.db).apply_post_engagement_weights(
                user=author, post_id=post_id, source="review"
            )
        await self.db.flush()
        await AchievementProgressService(self.db).evaluate_and_grant_after_review(
            user_id=author.id, post_id=post_id
        )
        await self.db.commit()
        await self.db.refresh(review)
        return await self.get_review_or_404(review.id)

    async def list_reviews_by_post(self, *, post_id: int, page: int, page_size: int) -> tuple[list[Review], int]:
        offset = (page - 1) * page_size
        total_stmt = select(func.count(Review.id)).where(Review.post_id == post_id)
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(Review)
            .where(Review.post_id == post_id)
            .options(selectinload(Review.author))
            .order_by(Review.created_at.desc(), Review.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return items, total

    async def list_reviews_by_author(
        self, *, author_id: int, page: int, page_size: int
    ) -> tuple[list[Review], int]:
        offset = (page - 1) * page_size
        total_stmt = select(func.count(Review.id)).where(Review.author_id == author_id)
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(Review)
            .where(Review.author_id == author_id)
            .options(selectinload(Review.post))
            .order_by(Review.created_at.desc(), Review.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return list(items), total

    async def get_review_or_404(self, review_id: int) -> Review:
        stmt = select(Review).where(Review.id == review_id).options(selectinload(Review.author)).limit(1)
        review = (await self.db.execute(stmt)).scalar_one_or_none()
        if review is None:
            raise HTTPException(status_code=404, detail="Review not found")
        return review

    async def delete_review(self, *, actor: User, review_id: int) -> None:
        review = await self.get_review_or_404(review_id)
        if review.author_id != actor.id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only author can delete review")
        await self.db.delete(review)
        await self.db.commit()
