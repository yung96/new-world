from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel
from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.post import Post
from app.models.user import User
from app.services.post_service import PostService

router = APIRouter()


class PostAuthorResponse(BasePydanticModel):
    id: int
    phone: str


class PostCreateRequest(BasePydanticModel):
    mediaUrls: list[str] = Field(default_factory=list)
    title: str
    description: str | None = None
    geoLat: float | None = Field(default=None, ge=-90, le=90)
    geoLng: float | None = Field(default=None, ge=-180, le=180)
    interestIds: list[int] = Field(default_factory=list)
    tags: list[str] = Field(default_factory=list)


class PostUpdateRequest(BasePydanticModel):
    mediaUrls: list[str] | None = None
    title: str | None = None
    description: str | None = None
    geoLat: float | None = Field(default=None, ge=-90, le=90)
    geoLng: float | None = Field(default=None, ge=-180, le=180)
    interestIds: list[int] | None = None
    tags: list[str] | None = None


class PostResponse(BasePydanticModel):
    id: int
    authorId: int
    mediaUrls: list[str]
    title: str
    description: str | None
    geoLat: float | None
    geoLng: float | None
    interestIds: list[int]
    tags: list[str]
    averageRating: float | None
    createdAt: datetime
    updatedAt: datetime
    author: PostAuthorResponse


class PostListResponse(BasePydanticModel):
    items: list[PostResponse]
    total: int
    page: int
    pageSize: int


def _service(db: AsyncSession) -> PostService:
    return PostService(db)


def _to_response(post: Post, average_rating: float | None = None) -> PostResponse:
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
        averageRating=(
            round(float(average_rating), 2) if average_rating is not None else None
        ),
        createdAt=post.created_at,
        updatedAt=post.updated_at,
        author=PostAuthorResponse(id=post.author.id, phone=post.author.phone),
    )


@router.post(
    "/posts",
    response_model=PostResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать пост",
    description="Создает новый пост от имени текущего пользователя.",
)
async def create_post(
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
    return _to_response(post, avg_rating)


@router.get(
    "/posts",
    response_model=PostListResponse,
    summary="Список постов",
    description="Возвращает список постов с пагинацией.",
)
async def list_posts(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    rows, total = await _service(db).list_posts(page=page, page_size=pageSize)
    items = [_to_response(post, avg_rating) for post, avg_rating in rows]
    return PostListResponse(items=items, total=total, page=page, pageSize=pageSize)


@router.get(
    "/posts/{post_id}",
    response_model=PostResponse,
    summary="Получить пост",
    description="Возвращает один пост по его идентификатору.",
)
async def get_post(post_id: int, db: AsyncSession = Depends(get_db_session)):
    post, avg_rating = await _service(db).get_post_or_404(post_id)
    return _to_response(post, avg_rating)


@router.patch(
    "/posts/{post_id}",
    response_model=PostResponse,
    summary="Обновить пост",
    description="Частично обновляет пост. Админский сценарий для MVP.",
)
async def update_post(
    post_id: int,
    payload: PostUpdateRequest,
    db: AsyncSession = Depends(get_db_session),
):
    updated = await _service(db).admin_update_post(
        post_id=post_id,
        title=payload.title,
        description=payload.description,
        geo_lat=payload.geoLat,
        geo_lng=payload.geoLng,
        media_urls=payload.mediaUrls,
        tags=payload.tags,
        interest_ids=payload.interestIds,
    )
    post, avg_rating = await _service(db).get_post_or_404(updated.id)
    return _to_response(post, avg_rating)


@router.delete(
    "/posts/{post_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить пост",
    description="Удаляет пост. Админский сценарий для MVP.",
)
async def delete_post(
    post_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).admin_delete_post(post_id=post_id)


@router.post(
    "/posts/{post_id}/interests/{interest_id}",
    response_model=PostResponse,
    summary="Добавить интерес к посту",
    description="Привязывает интерес к посту. Админский сценарий для MVP.",
)
async def add_interest_to_post(
    post_id: int,
    interest_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    updated = await _service(db).admin_add_interest(post_id=post_id, interest_id=interest_id)
    post, avg_rating = await _service(db).get_post_or_404(updated.id)
    return _to_response(post, avg_rating)


@router.delete(
    "/posts/{post_id}/interests/{interest_id}",
    response_model=PostResponse,
    summary="Убрать интерес из поста",
    description="Удаляет привязку интереса к посту. Админский сценарий для MVP.",
)
async def remove_interest_from_post(
    post_id: int,
    interest_id: int,
    db: AsyncSession = Depends(get_db_session),
):
    updated = await _service(db).admin_remove_interest(
        post_id=post_id, interest_id=interest_id
    )
    post, avg_rating = await _service(db).get_post_or_404(updated.id)
    return _to_response(post, avg_rating)
