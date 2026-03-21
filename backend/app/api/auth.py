from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import Field
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel

from app.core.dependencies import get_db_session
from app.models.achievement import Achievement
from app.models.associations import user_achievements
from app.models.interest import Interest
from app.models.review import Review
from app.models.user import User
from app.services.achievement_progress_service import AchievementProgressService
from app.services.auth_service import AuthService
from app.services.review_service import ReviewService
from app.services.social_service import SocialService

# --- Схемы (DTOs) ---


class LoginData(BasePydanticModel):
    phone: str = Field(
        ...,
        description="Номер телефона пользователя (пробелы по краям будут обрезаны).",
        examples=["+79991234567"],
    )


class Token(BasePydanticModel):
    access_token: str = Field(..., description="JWT токен доступа.")
    token_type: str = Field(default="bearer", description="Тип токена.")


class UserData(BasePydanticModel):
    id: int = Field(..., description="Уникальный идентификатор пользователя.")
    phone: str = Field(..., description="Телефон пользователя.")
    created_at: datetime = Field(
        ..., description="Дата и время регистрации пользователя."
    )


class UserPublicReviewItem(BasePydanticModel):
    id: int = Field(description="Идентификатор отзыва.")
    postId: int = Field(description="Идентификатор карточки места.")
    postTitle: str = Field(description="Название места.")
    postRegionId: int | None = Field(description="Идентификатор региона места.")
    rating: int = Field(description="Оценка 1–5.")
    comment: str | None = Field(description="Текст отзыва.")
    mediaUrls: list[str] = Field(description="Медиа отзыва.")
    createdAt: datetime = Field(description="Время публикации отзыва.")


class PublicUserAchievementItem(BasePydanticModel):
    id: int
    name: str
    description: str | None
    interestId: int | None
    interestName: str
    earnedAt: datetime


class UserPublicProfileResponse(BasePydanticModel):
    id: int
    phone: str = Field(description="Телефон пользователя (как в других compact-ответах).")
    followersCount: int = Field(description="Число подписчиков (кто подписан на этого пользователя).")
    achievements: list[PublicUserAchievementItem] = Field(
        description="Только полученные достижения (видны всем).",
    )
    reviews: list[UserPublicReviewItem]
    total: int = Field(description="Общее число отзывов автора (для пагинации).")
    page: int
    pageSize: int


class AchievementProgressItemResponse(BasePydanticModel):
    achievementId: int
    name: str
    description: str | None
    interestId: int
    interestName: str
    requiredDistinctPosts: int
    currentCount: int
    unlocked: bool
    earnedAt: datetime | None


class AchievementProgressListResponse(BasePydanticModel):
    items: list[AchievementProgressItemResponse]


def _review_to_public_item(review: Review) -> UserPublicReviewItem:
    return UserPublicReviewItem(
        id=review.id,
        postId=review.post_id,
        postTitle=review.post.title,
        postRegionId=review.post.region_id,
        rating=review.rating,
        comment=review.comment,
        mediaUrls=list(review.media_urls or []),
        createdAt=review.created_at,
    )


async def _public_achievements_for_user(db, user_id: int) -> list[PublicUserAchievementItem]:
    stmt = (
        select(Achievement, user_achievements.c.earned_at, Interest.name)
        .join(user_achievements, user_achievements.c.achievement_id == Achievement.id)
        .join(Interest, Interest.id == Achievement.interest_id)
        .where(user_achievements.c.user_id == user_id)
        .order_by(user_achievements.c.earned_at.desc())
    )
    rows = (await db.execute(stmt)).all()
    out: list[PublicUserAchievementItem] = []
    for ach, earned_at, interest_name in rows:
        out.append(
            PublicUserAchievementItem(
                id=ach.id,
                name=ach.name,
                description=ach.description,
                interestId=ach.interest_id,
                interestName=str(interest_name),
                earnedAt=earned_at,
            )
        )
    return out


# --- Настройка FastAPI ---

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/api/auth",
    description="Вставьте токен в формате `Bearer <token>`.",
)


# --- Зависимости ---


def get_auth_service(db: AsyncSession = Depends(get_db_session)) -> AuthService:
    return AuthService(db)


async def get_current_user(
    token: str = Depends(oauth2_scheme),
    auth_service: AuthService = Depends(get_auth_service),
) -> User:
    return await auth_service.get_user_from_token(token)


# --- Роуты ---
@router.post(
    "/auth",
    response_model=Token,
    status_code=status.HTTP_200_OK,
    summary="Авторизация пользователя",
    description="Принимает номер телефона и возвращает JWT access token.",
    response_description="Успешная авторизация и токен доступа.",
)
async def login(
    data: LoginData,
    auth_service: AuthService = Depends(get_auth_service),
):
    """
    Авторизация по номеру телефона.
    """
    access_token = await auth_service.login(data.phone)
    return {"access_token": access_token}


@router.get(
    "/users/me",
    response_model=UserData,
    summary="Профиль текущего пользователя",
    description="Возвращает данные пользователя, определенного по Bearer токену.",
    response_description="Профиль авторизованного пользователя.",
)
async def get_user(current_user: User = Depends(get_current_user)):
    """
    Возвращает информацию о текущем авторизованном пользователе.
    """
    return current_user


@router.get(
    "/users/me/achievements/progress",
    response_model=AchievementProgressListResponse,
    summary="Прогресс достижений (текущий пользователь)",
    operation_id="get_my_achievement_progress",
    description=(
        "Условия и прогресс по всем правилам достижений (интерес + N уникальных карточек с отзывами). "
        "Требуется Bearer-токен."
    ),
)
async def get_my_achievement_progress(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    rows = await AchievementProgressService(db).list_progress(user_id=current_user.id)
    return AchievementProgressListResponse(
        items=[
            AchievementProgressItemResponse(
                achievementId=r.achievement_id,
                name=r.name,
                description=r.description,
                interestId=r.interest_id,
                interestName=r.interest_name,
                requiredDistinctPosts=r.required_distinct_posts,
                currentCount=r.current_count,
                unlocked=r.unlocked,
                earnedAt=r.earned_at,
            )
            for r in rows
        ]
    )


@router.get(
    "/users/{user_id}",
    response_model=UserPublicProfileResponse,
    summary="Публичный профиль пользователя",
    operation_id="get_public_user_profile",
    description=(
        "Профиль другого пользователя: число подписчиков и пагинированный список его отзывов "
        "с привязкой к карточкам мест (postId, название, город). Авторизация не требуется."
    ),
    response_description="Идентификатор, телефон, число подписчиков и отзывы.",
)
async def get_public_user_profile(
    user_id: int,
    page: int = Query(default=1, ge=1, description="Страница списка отзывов."),
    pageSize: int = Query(default=20, ge=1, le=100, description="Размер страницы отзывов."),
    db: AsyncSession = Depends(get_db_session),
):
    social = SocialService(db)
    user = await social.get_user_or_404(user_id)
    followers_count = await social.count_followers(user_id=user.id)
    reviews, total = await ReviewService(db).list_reviews_by_author(
        author_id=user.id, page=page, page_size=pageSize
    )
    achievements = await _public_achievements_for_user(db, user.id)
    return UserPublicProfileResponse(
        id=user.id,
        phone=user.phone,
        followersCount=followers_count,
        achievements=achievements,
        reviews=[_review_to_public_item(r) for r in reviews],
        total=total,
        page=page,
        pageSize=pageSize,
    )
