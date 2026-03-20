from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.posts import PostCreateRequest, PostResponse
from app.core.dependencies import get_db_session
from app.models.user import User
from app.services.post_service import PostService

router = APIRouter(prefix="/user")


def _service(db: AsyncSession) -> PostService:
    return PostService(db)


@router.post(
    "/posts",
    response_model=PostResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать место (пост) как пользователь",
    description="Обычный user endpoint для создания поста.",
)
async def user_create_post(
    payload: PostCreateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    created = await _service(db).create_post(
        author=current_user,
        title=payload.title,
        description=payload.description,
        geo_lat=payload.geoLat,
        geo_lng=payload.geoLng,
        media_urls=payload.mediaUrls,
        tags=payload.tags,
        interest_ids=payload.interestIds,
    )
    post, avg_rating = await _service(db).get_post_or_404(created.id)
    return PostResponse(
        id=post.id,
        authorId=post.author_id,
        mediaUrls=list(post.media_urls or []),
        title=post.title,
        description=post.description,
        geoLat=post.geo_lat,
        geoLng=post.geo_lng,
        interestIds=[interest.id for interest in post.interests],
        tags=list(post.tags or []),
        averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
        createdAt=post.created_at,
        updatedAt=post.updated_at,
        author={"id": post.author.id, "phone": post.author.phone},
    )

