from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from pydantic import BaseModel, Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.review import Review
from app.models.user import User
from app.services.review_service import ReviewService

router = APIRouter()


class ReviewAuthorResponse(BaseModel):
    id: int
    phone: str


class ReviewCreateRequest(BaseModel):
    rating: int = Field(ge=1, le=5)
    comment: str | None = None
    mediaUrls: list[str] = Field(default_factory=list)


class ReviewResponse(BaseModel):
    id: int
    authorId: int
    postId: int
    rating: int
    comment: str | None
    mediaUrls: list[str]
    createdAt: datetime
    author: ReviewAuthorResponse


class ReviewListResponse(BaseModel):
    items: list[ReviewResponse]
    total: int
    page: int
    pageSize: int


def _service(db: AsyncSession) -> ReviewService:
    return ReviewService(db)


def _to_response(review: Review) -> ReviewResponse:
    return ReviewResponse(
        id=review.id,
        authorId=review.author_id,
        postId=review.post_id,
        rating=review.rating,
        comment=review.comment,
        mediaUrls=list(review.media_urls or []),
        createdAt=review.created_at,
        author=ReviewAuthorResponse(id=review.author.id, phone=review.author.phone),
    )


@router.post(
    "/posts/{post_id}/reviews",
    response_model=ReviewResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать отзыв",
    description="Создает отзыв к посту от имени текущего пользователя.",
)
async def create_review(
    post_id: int,
    payload: ReviewCreateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    review = await _service(db).create_review(
        author=current_user,
        post_id=post_id,
        rating=payload.rating,
        comment=payload.comment,
        media_urls=payload.mediaUrls,
    )
    return _to_response(review)


@router.get(
    "/posts/{post_id}/reviews",
    response_model=ReviewListResponse,
    summary="Список отзывов поста",
    description="Возвращает отзывы к посту с пагинацией.",
)
async def list_reviews(
    post_id: int,
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    reviews, total = await _service(db).list_reviews_by_post(post_id=post_id, page=page, page_size=pageSize)
    return ReviewListResponse(
        items=[_to_response(review) for review in reviews],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.delete(
    "/reviews/{review_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить отзыв",
    description="Удаляет отзыв. Доступно только автору отзыва.",
)
async def delete_review(
    review_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_review(actor=current_user, review_id=review_id)
