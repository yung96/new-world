from datetime import datetime
import re
import unicodedata

from fastapi import APIRouter, Depends, Query, status
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel
from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.achievement import Achievement
from app.models.interest import Interest
from app.models.user import User
from app.services.social_service import SocialService
from app.services.gpt_service import GptService

router = APIRouter()


class UserCompactResponse(BasePydanticModel):
    id: int
    phone: str


class InterestRequest(BasePydanticModel):
    name: str
    emoji: str | None = None


class InterestResponse(BasePydanticModel):
    id: int
    name: str
    name_en: str
    emoji: str


class AchievementRequest(BasePydanticModel):
    name: str
    description: str | None = None


class AchievementResponse(BasePydanticModel):
    id: int
    name: str
    description: str | None
    createdAt: datetime


class PaginatedInterestsResponse(BasePydanticModel):
    items: list[InterestResponse]
    total: int
    page: int
    pageSize: int


class PaginatedAchievementsResponse(BasePydanticModel):
    items: list[AchievementResponse]
    total: int
    page: int
    pageSize: int


class SubscriptionCreateRequest(BasePydanticModel):
    targetUserId: int


class PaginatedFollowingResponse(BasePydanticModel):
    items: list[UserCompactResponse]
    total: int
    page: int
    pageSize: int


class GeneratedInterest(BasePydanticModel):
    ids: list[int]


def _service(db: AsyncSession) -> SocialService:
    return SocialService(db)


def _gpt_service() -> GptService:
    return GptService()


def _interest_to_response(item: Interest) -> InterestResponse:
    slug = (
        unicodedata.normalize("NFKD", item.name)
        .encode("ascii", "ignore")
        .decode("ascii")
        .lower()
    )
    slug = re.sub(r"[^a-z0-9]+", "_", slug).strip("_")
    if not slug:
        slug = f"interest_{item.id}"
    return InterestResponse(
        id=item.id,
        name=item.name,
        name_en=slug,
        emoji=item.emoji or "",
    )


def _achievement_to_response(item: Achievement) -> AchievementResponse:
    return AchievementResponse(
        id=item.id,
        name=item.name,
        description=item.description,
        createdAt=item.created_at,
    )


@router.post(
    "/interests",
    response_model=InterestResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать интерес",
    description="Создает новый интерес в общем справочнике интересов.",
    response_description="Созданный интерес.",
)
async def create_interest(
    payload: InterestRequest,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).create_interest(payload.name, payload.emoji)
    return _interest_to_response(item)


@router.get(
    "/interests",
    response_model=PaginatedInterestsResponse,
    summary="Список интересов",
    description="Возвращает пагинированный список всех интересов.",
    response_description="Список интересов с пагинацией.",
)
async def list_interests(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_interests(page=page, page_size=pageSize)
    return PaginatedInterestsResponse(
        items=[_interest_to_response(item) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.post(
    "/interests/bulk_create",
    response_model=PaginatedInterestsResponse,
    summary="Добавить интересы пользователю",
    description="Привязывает набор интересов к текущему пользователю и возвращает его интересы.",
    response_description="Актуальный список интересов пользователя.",
)
async def add_interests(
    interest_ids: list[int] = ...,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).add_interests_to_user(
        user=_current_user,
        interest_ids=interest_ids,
    )
    interests = await _service(db).get_interests_by_user(user_id=_current_user.id)
    return PaginatedInterestsResponse(
        items=[_interest_to_response(item) for item in interests],
        total=100,
        page=1,
        pageSize=100,
    )


@router.post(
    "/interests/generate",
    response_model=PaginatedInterestsResponse,
    summary="Сгенерировать интересы по тексту",
    description="Определяет интересы пользователя по свободному тексту и сохраняет их.",
    response_description="Актуальный список интересов пользователя.",
)
async def generate_interests(
    user_data: str = ...,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    # NOTE: 100 интересов учитываются, по-хорошему надо все.
    items, total = await _service(db).list_interests(page=1, page_size=100)

    sys_prompt = (
        f"Тебе необходимо выделить основные интересы на основе "
        f"пользовательского ввода, которые есть в нашей системе {items}"
    )
    user_prompt = user_data
    generated_interests, _ = await _gpt_service().request_openai_pydantic_response(
        sys_prompt=sys_prompt,
        user_prompt=user_prompt,
        response_model=GeneratedInterest,
    )

    await _service(db).add_interests_to_user(
        user=_current_user,
        interest_ids=generated_interests.ids,
    )
    interests = await _service(db).get_interests_by_user(user_id=_current_user.id)
    return PaginatedInterestsResponse(
        items=[_interest_to_response(item) for item in interests],
        total=total,
        page=1,
        pageSize=100,
    )


@router.delete(
    "/interests/{interest_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить интерес",
    description="Удаляет интерес из справочника.",
)
async def delete_interest(
    interest_id: int,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_interest(interest_id)


@router.post(
    "/users/me/interests/{interest_id}",
    response_model=UserCompactResponse,
    summary="Добавить интерес текущему пользователю",
    description="Привязывает интерес к профилю текущего пользователя.",
    response_description="Краткие данные пользователя после обновления.",
)
async def add_interest_to_me(
    interest_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).add_interest_to_user(
        user=current_user, interest_id=interest_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.delete(
    "/users/me/interests/{interest_id}",
    response_model=UserCompactResponse,
    summary="Убрать интерес у текущего пользователя",
    description="Удаляет привязку интереса у текущего пользователя.",
    response_description="Краткие данные пользователя после обновления.",
)
async def remove_interest_from_me(
    interest_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).remove_interest_from_user(
        user=current_user, interest_id=interest_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.post(
    "/achievements",
    response_model=AchievementResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Создать достижение",
    description="Создает новое достижение в справочнике достижений.",
    response_description="Созданное достижение.",
)
async def create_achievement(
    payload: AchievementRequest,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    item = await _service(db).create_achievement(
        name=payload.name, description=payload.description
    )
    return _achievement_to_response(item)


@router.get(
    "/achievements",
    response_model=PaginatedAchievementsResponse,
    summary="Список достижений",
    description="Возвращает пагинированный список достижений.",
    response_description="Список достижений с пагинацией.",
)
async def list_achievements(
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_achievements(page=page, page_size=pageSize)
    return PaginatedAchievementsResponse(
        items=[_achievement_to_response(item) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.delete(
    "/achievements/{achievement_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить достижение",
    description="Удаляет достижение из справочника.",
)
async def delete_achievement(
    achievement_id: int,
    _current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).delete_achievement(achievement_id)


@router.post(
    "/users/me/achievements/{achievement_id}",
    response_model=UserCompactResponse,
    summary="Добавить достижение текущему пользователю",
    description="Привязывает достижение к текущему пользователю.",
    response_description="Краткие данные пользователя после обновления.",
)
async def add_achievement_to_me(
    achievement_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).add_achievement_to_user(
        user=current_user, achievement_id=achievement_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.delete(
    "/users/me/achievements/{achievement_id}",
    response_model=UserCompactResponse,
    summary="Убрать достижение у текущего пользователя",
    description="Удаляет достижение из профиля текущего пользователя.",
    response_description="Краткие данные пользователя после обновления.",
)
async def remove_achievement_from_me(
    achievement_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    user = await _service(db).remove_achievement_from_user(
        user=current_user, achievement_id=achievement_id
    )
    return UserCompactResponse(id=user.id, phone=user.phone)


@router.post(
    "/subscriptions",
    status_code=status.HTTP_201_CREATED,
    summary="Подписаться на пользователя",
    operation_id="create_subscription",
    description=(
        "**Путь:** `POST /api/subscriptions`. Тело: `{\"targetUserId\": <id>}`. "
        "Создаёт одностороннюю подписку текущего пользователя на другого."
    ),
    response_description="Тело ответа пустое при успехе (201).",
)
async def create_subscription(
    payload: SubscriptionCreateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).subscribe(
        subscriber=current_user, following_id=payload.targetUserId
    )


@router.get(
    "/subscriptions",
    response_model=PaginatedFollowingResponse,
    summary="Список подписок",
    operation_id="list_subscriptions",
    description=(
        "**Путь:** `GET /api/subscriptions`. "
        "Пользователи, на которых подписан текущий пользователь (на кого я подписан)."
    ),
    response_description="Список подписок с пагинацией.",
)
async def list_subscriptions(
    current_user: User = Depends(get_current_user),
    page: int = Query(default=1, ge=1),
    pageSize: int = Query(default=20, ge=1, le=100),
    db: AsyncSession = Depends(get_db_session),
):
    items, total = await _service(db).list_following(
        current_user, page=page, page_size=pageSize
    )
    return PaginatedFollowingResponse(
        items=[UserCompactResponse(id=item.id, phone=item.phone) for item in items],
        total=total,
        page=page,
        pageSize=pageSize,
    )


@router.delete(
    "/subscriptions/{target_user_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Отписаться от пользователя",
    operation_id="delete_subscription",
    description=(
        "**Путь:** `DELETE /api/subscriptions/{target_user_id}`. "
        "Удаляет подписку; повторный вызов без ошибки (идемпотентно)."
    ),
    response_description="Пустой ответ при успехе (204).",
)
async def delete_subscription(
    target_user_id: int,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    await _service(db).unsubscribe(
        subscriber=current_user, following_id=target_user_id
    )
