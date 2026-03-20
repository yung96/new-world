from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.posts import PostCreateRequest, PostListResponse, PostResponse
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
    description="Пользователь создает новое место. Возвращает созданный объект поста.",
    response_description="Созданное место.",
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
        season=payload.season,
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
        season=post.season,
        averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
        createdAt=post.created_at,
        updatedAt=post.updated_at,
        author={"id": post.author.id, "phone": post.author.phone},
    )


@router.post(
    "/favorites/{post_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Добавить место в избранное",
    description="Добавляет место в персональный список избранного текущего пользователя.",
)
async def add_to_favorites(
    post_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).add_favorite(user=current_user, post_id=post_id)


@router.delete(
    "/favorites/{post_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Убрать место из избранного",
    description="Удаляет место из персонального списка избранного текущего пользователя.",
)
async def remove_from_favorites(
    post_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).remove_favorite(user=current_user, post_id=post_id)


@router.get(
    "/favorites",
    response_model=PostListResponse,
    summary="Список избранных мест пользователя",
    description="Возвращает пагинированный список избранных мест текущего пользователя.",
    response_description="Список избранных мест.",
)
async def list_favorites(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    rows, total = await _service(db).list_favorites(
        user=current_user, page=page, page_size=pageSize
    )
    items = [
        PostResponse(
            id=post.id,
            authorId=post.author_id,
            mediaUrls=list(post.media_urls or []),
            title=post.title,
            description=post.description,
            geoLat=post.geo_lat,
            geoLng=post.geo_lng,
            interestIds=[interest.id for interest in post.interests],
            season=post.season,
            averageRating=(
                round(float(avg_rating), 2) if avg_rating is not None else None
            ),
            createdAt=post.created_at,
            updatedAt=post.updated_at,
            author={"id": post.author.id, "phone": post.author.phone},
        )
        for post, avg_rating in rows
    ]
    return PostListResponse(items=items, total=total, page=page, pageSize=pageSize)

