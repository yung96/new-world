from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.base_schema import BasePydanticModel
from app.api.posts import PostCreateRequest, PostListResponse, PostResponse
from app.api.reviews import ReviewAuthorResponse
from app.core.dependencies import get_db_session
from app.models.review import Review
from app.models.user import User
from app.services.feed_service import FeedService
from app.services.post_service import PostService
from app.services.swipe_service import SwipeDirection, SwipeService
from app.services.user_route_service import UserRouteService

router = APIRouter(prefix="/user")


def _service(db: AsyncSession) -> PostService:
    return PostService(db)


def _feed_service(db: AsyncSession) -> FeedService:
    return FeedService(db)


def _swipe_service(db: AsyncSession) -> SwipeService:
    return SwipeService(db)


def _user_route_service(db: AsyncSession) -> UserRouteService:
    return UserRouteService(db)


def _to_post_response(post, avg_rating: float | None) -> PostResponse:
    return PostResponse(
        id=post.id,
        title=post.title,
        regionId=post.region_id,
        city=post.city,
        description=post.description,
        geoLat=post.geo_lat,
        geoLng=post.geo_lng,
        address=post.address,
        phone=post.phone,
        email=post.email,
        website=post.website,
        needCar=post.need_car,
        priceLevel=post.price_level,
        durationHours=post.duration_hours,
        bestAngle=post.best_angle,
        verified=post.verified,
        interestIds=[interest.id for interest in post.interests],
        season=post.season,
        averageRating=(round(float(avg_rating), 2) if avg_rating is not None else None),
        reviewsCount=post.reviews_count,
        createdAt=post.created_at,
        updatedAt=post.updated_at,
    )


class SwipeRequest(BasePydanticModel):
    postId: int
    direction: SwipeDirection


class SwipeActionResponse(BasePydanticModel):
    postId: int
    direction: SwipeDirection
    alreadySwiped: bool = Field(
        description="true, если карточка уже была свайпнута ранее."
    )
    addedToFavorites: bool = Field(
        description="true, если свайп вправо добавил карточку в избранное."
    )


class SwipeNextResponse(BasePydanticModel):
    done: bool = Field(
        description="true, если карточки закончились и показывать больше нечего."
    )
    message: str | None = Field(default=None, description="Сообщение для клиента.")
    post: PostResponse | None = Field(default=None, description="Следующая карточка.")


class SubscriptionActivityItemResponse(BasePydanticModel):
    """Элемент ленты подписок: отзыв + краткие данные о месте (посте)."""

    id: int = Field(description="Идентификатор отзыва.")
    authorId: int = Field(description="Автор отзыва (пользователь, на которого можно подписаться).")
    postId: int = Field(description="Идентификатор места (поста).")
    rating: int = Field(description="Оценка 1–5.")
    comment: str | None = Field(description="Текст отзыва.")
    mediaUrls: list[str] = Field(description="URL медиа к отзыву.")
    createdAt: datetime = Field(description="Время публикации отзыва (сортировка ленты по убыванию).")
    author: ReviewAuthorResponse
    postTitle: str = Field(description="Название места.")
    postCity: str | None = Field(description="Город места (если указан у поста).")
    postRegionId: int | None = Field(description="Идентификатор региона места.")


class SubscriptionActivityListResponse(BasePydanticModel):
    items: list[SubscriptionActivityItemResponse] = Field(
        description="Отзывы от пользователей, на которых подписан текущий клиент."
    )
    total: int = Field(description="Общее число отзывов в ленте (с учётом фильтра подписок).")
    page: int
    pageSize: int


class UserSavedRouteCreateRequest(BasePydanticModel):
    title: str | None = None
    startLat: float = Field(ge=-90, le=90)
    startLng: float = Field(ge=-180, le=180)
    startLabel: str | None = None
    postIds: list[int] = Field(default_factory=list)


class UserSavedRoutePatchRequest(BasePydanticModel):
    title: str | None = None
    startLat: float | None = Field(default=None, ge=-90, le=90)
    startLng: float | None = Field(default=None, ge=-180, le=180)
    startLabel: str | None = None
    postIds: list[int] | None = None


class UserSavedRouteResponse(BasePydanticModel):
    id: int
    title: str | None
    startLat: float
    startLng: float
    startLabel: str | None = None
    postIds: list[int]
    posts: list[PostResponse]
    aiGenerated: bool = False
    aiRouteMeta: dict | None = None


class UserSavedRouteListResponse(BasePydanticModel):
    items: list[UserSavedRouteResponse]
    total: int
    page: int
    pageSize: int


async def _to_user_saved_route_response(
    db: AsyncSession, route
) -> UserSavedRouteResponse:
    rsvc = _user_route_service(db)
    ids = [it.post_id for it in sorted(route.items, key=lambda x: x.position)]
    if not ids:
        posts_out: list[PostResponse] = []
    else:
        rows = await rsvc.posts_with_ratings_ordered(ids)
        posts_out = [_to_post_response(p, avg) for p, avg in rows]
    return UserSavedRouteResponse(
        id=route.id,
        title=route.title,
        startLat=route.start_lat,
        startLng=route.start_lng,
        startLabel=route.start_label,
        postIds=ids,
        posts=posts_out,
        aiGenerated=route.ai_generated,
        aiRouteMeta=route.ai_route_meta,
    )


def _to_subscription_activity_item(review: Review) -> SubscriptionActivityItemResponse:
    return SubscriptionActivityItemResponse(
        id=review.id,
        authorId=review.author_id,
        postId=review.post_id,
        rating=review.rating,
        comment=review.comment,
        mediaUrls=list(review.media_urls or []),
        createdAt=review.created_at,
        author=ReviewAuthorResponse(id=review.author.id, phone=review.author.phone),
        postTitle=review.post.title,
        postCity=review.post.city,
        postRegionId=review.post.region_id,
    )


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
        city=payload.city,
        description=payload.description,
        geo_lat=payload.geoLat,
        geo_lng=payload.geoLng,
        season=payload.season,
        interest_ids=payload.interestIds,
    )
    post, avg_rating = await _service(db).get_post_or_404(created.id)
    return _to_post_response(post, avg_rating)


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
    items = [_to_post_response(post, avg_rating) for post, avg_rating in rows]
    return PostListResponse(items=items, total=total, page=page, pageSize=pageSize)


@router.get(
    "/feed",
    response_model=PostListResponse,
    summary="Персонализированная лента мест",
    description=(
        "Лента с учётом весов интересов пользователя, смешанная с популярными, "
        "нишевыми и случайными карточками из последних постов."
    ),
)
async def user_feed(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    rows, total = await _feed_service(db).list_feed(
        user=current_user, page=page, page_size=pageSize
    )
    items = [_to_post_response(post, avg_rating) for post, avg_rating in rows]
    return PostListResponse(items=items, total=total, page=page, pageSize=pageSize)


@router.get(
    "/subscriptions/feed",
    response_model=SubscriptionActivityListResponse,
    summary="Лента активности подписок",
    operation_id="get_user_subscriptions_feed",
    description=(
        "**Полный путь:** `GET /api/user/subscriptions/feed`. "
        "Требуется заголовок `Authorization: Bearer <token>` (как для остальных user-эндпоинтов). "
        "Возвращает хронологический список отзывов о местах от пользователей, на которых подписан "
        "текущий пользователь (сортировка по `createdAt` у отзыва, новые выше). "
        "Не смешивается с рекомендательной лентой карточек (`GET /user/feed`)."
    ),
    response_description="Страница отзывов с полями автора и места (postTitle, postRegionId).",
)
async def subscription_activity_feed(
    page: int = Query(
        default=1,
        ge=1,
        description="Номер страницы (с 1).",
    ),
    pageSize: int = Query(
        default=20,
        ge=1,
        le=100,
        description="Размер страницы.",
    ),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    reviews, total = await _feed_service(db).list_subscription_activity(
        user=current_user, page=page, page_size=pageSize
    )
    items = [_to_subscription_activity_item(r) for r in reviews]
    return SubscriptionActivityListResponse(
        items=items, total=total, page=page, pageSize=pageSize
    )


@router.get(
    "/swipes/next",
    response_model=SwipeNextResponse,
    summary="Следующая карточка для свайпа",
    description=(
        "Возвращает следующую карточку на основе рекомендательной ленты. "
        "Уже свайпнутые карточки исключаются."
    ),
    response_description="Следующая карточка или сообщение, что карточки закончились.",
)
async def get_next_swipe_card(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    row, _ = await _swipe_service(db).get_next_card(user=current_user)
    if row is None:
        return SwipeNextResponse(
            done=True,
            message="Карточки закончились",
            post=None,
        )
    post, avg_rating = row
    return SwipeNextResponse(
        done=False,
        message=None,
        post=_to_post_response(post, avg_rating),
    )


@router.post(
    "/swipes",
    response_model=SwipeActionResponse,
    summary="Свайпнуть карточку",
    description=(
        "Регистрирует свайп по карточке. "
        "Свайп вправо добавляет карточку в избранное и повышает веса интересов, "
        "свайп влево не изменяет веса."
    ),
    response_description="Результат обработки свайпа.",
)
async def swipe_card(
    payload: SwipeRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    inserted = await _swipe_service(db).swipe(
        user=current_user,
        post_id=payload.postId,
        direction=payload.direction,
    )
    return SwipeActionResponse(
        postId=payload.postId,
        direction=payload.direction,
        alreadySwiped=not inserted,
        addedToFavorites=inserted and payload.direction is SwipeDirection.right,
    )


@router.post(
    "/routes",
    response_model=UserSavedRouteResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать сохранённый маршрут (точка А + цепочка мест)",
)
async def user_create_saved_route(
    payload: UserSavedRouteCreateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    rsvc = _user_route_service(db)
    route = await rsvc.create_route(
        user=current_user,
        title=payload.title,
        start_lat=payload.startLat,
        start_lng=payload.startLng,
        start_label=payload.startLabel,
        post_ids=payload.postIds,
    )
    loaded = await rsvc.get_route_owned(user_id=current_user.id, route_id=route.id)
    return await _to_user_saved_route_response(db, loaded)


@router.get(
    "/routes",
    response_model=UserSavedRouteListResponse,
    summary="Список сохранённых маршрутов",
)
async def user_list_saved_routes(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    routes, total = await _user_route_service(db).list_routes(
        user=current_user, page=page, page_size=pageSize
    )
    items = [await _to_user_saved_route_response(db, r) for r in routes]
    return UserSavedRouteListResponse(
        items=items, total=total, page=page, pageSize=pageSize
    )


@router.get(
    "/routes/{route_id}",
    response_model=UserSavedRouteResponse,
    summary="Получить сохранённый маршрут",
)
async def user_get_saved_route(
    route_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    route = await _user_route_service(db).get_route_owned(
        user_id=current_user.id, route_id=route_id
    )
    return await _to_user_saved_route_response(db, route)


@router.patch(
    "/routes/{route_id}",
    response_model=UserSavedRouteResponse,
    summary="Обновить сохранённый маршрут",
)
async def user_patch_saved_route(
    route_id: int,
    payload: UserSavedRoutePatchRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    from app.services.user_route_service import UNSET

    rsvc = _user_route_service(db)
    fs = payload.model_fields_set
    patch_kwargs: dict = {}
    if "title" in fs:
        patch_kwargs["title"] = payload.title
    if "startLat" in fs and "startLng" in fs:
        patch_kwargs["start_lat"] = payload.startLat
        patch_kwargs["start_lng"] = payload.startLng
    elif "startLat" in fs or "startLng" in fs:
        patch_kwargs["start_lat"] = (
            payload.startLat if "startLat" in fs else UNSET
        )
        patch_kwargs["start_lng"] = (
            payload.startLng if "startLng" in fs else UNSET
        )
    if "startLabel" in fs:
        patch_kwargs["start_label"] = payload.startLabel
    if "postIds" in fs:
        patch_kwargs["post_ids"] = payload.postIds

    uid = current_user.id
    await rsvc.update_route(
        user=current_user,
        route_id=route_id,
        **patch_kwargs,
    )
    route = await rsvc.get_route_owned(user_id=uid, route_id=route_id)
    return await _to_user_saved_route_response(db, route)


@router.delete(
    "/routes/{route_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить сохранённый маршрут",
)
async def user_delete_saved_route(
    route_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _user_route_service(db).delete_route(
        user_id=current_user.id, route_id=route_id
    )

