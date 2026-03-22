from datetime import datetime
from typing import Literal

from fastapi import APIRouter, Depends, HTTPException, Query, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import Field
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel

from app.core.dependencies import get_db_session
from app.models.achievement import Achievement
from app.models.associations import user_achievements, UserSwipedPost
from app.models.interest import Interest
from app.models.associations import user_interests, post_interests
from app.models.post import Post
from app.models.review import Review
from app.models.route import Route
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
    postCity: str | None = Field(description="Город места (если указан у поста).")
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
        postCity=review.post.city,
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


# --- Profile endpoints ---


@router.get(
    "/users/me/interests",
    summary="Мои интересы",
)
async def get_my_interests(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    stmt = (
        select(Interest)
        .join(user_interests, user_interests.c.interest_id == Interest.id)
        .where(user_interests.c.user_id == current_user.id)
    )
    result = await db.execute(stmt)
    interests = result.scalars().all()
    return [
        {"id": i.id, "name": i.name, "emoji": i.emoji}
        for i in interests
    ]


@router.get(
    "/users/me/routes",
    summary="Мои маршруты",
)
async def get_my_routes(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    stmt = (
        select(Route)
        .where(Route.author_id == current_user.id)
        .order_by(Route.created_at.desc())
    )
    result = await db.execute(stmt)
    routes = result.scalars().all()
    return [
        {
            "id": r.id,
            "title": r.title,
            "status": r.status.value if hasattr(r.status, "value") else str(r.status),
            "totalDays": r.total_days,
            "totalExperiences": r.total_experiences,
            "totalPrice": r.total_price,
            "shareToken": r.share_token,
            "createdAt": r.created_at.isoformat() if r.created_at else None,
        }
        for r in routes
    ]


@router.patch(
    "/users/me",
    summary="Обновить профиль",
)
async def update_me(
    body: dict,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    allowed = {"name", "avatar_url", "bio"}
    for key, val in body.items():
        if key in allowed:
            setattr(current_user, key, val)
    await db.commit()
    await db.refresh(current_user)
    return {
        "id": current_user.id,
        "phone": current_user.phone,
        "name": current_user.name,
        "avatarUrl": current_user.avatar_url,
        "bio": current_user.bio,
    }


# --- Onboarding schemas ---


class OnboardingCompleteRequest(BasePydanticModel):
    interestIds: list[int] = Field(default_factory=list, description="ID интересов, отмеченных пользователем во время онбординга.")


class OnboardingCompleteResponse(BasePydanticModel):
    ok: bool
    count: int = Field(description="Число новых записей, добавленных в user_interests.")


class OnboardingSwipeRequest(BasePydanticModel):
    postId: int = Field(description="ID карточки места.")
    direction: Literal["left", "right"] = Field(description="Направление свайпа: right — понравилось, left — нет.")


class OnboardingSwipeResponse(BasePydanticModel):
    ok: bool


# --- Onboarding endpoints ---


@router.post(
    "/onboarding/complete",
    response_model=OnboardingCompleteResponse,
    summary="Завершить онбординг — привязать интересы по свайпам",
)
async def onboarding_complete(
    body: OnboardingCompleteRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    if not body.interestIds:
        return OnboardingCompleteResponse(ok=True, count=0)

    # Verify all interest IDs actually exist
    existing_stmt = select(Interest.id).where(Interest.id.in_(body.interestIds))
    existing_ids = {row[0] for row in (await db.execute(existing_stmt)).fetchall()}

    # Find which ones the user doesn't have yet
    already_stmt = select(user_interests.c.interest_id).where(
        user_interests.c.user_id == current_user.id,
        user_interests.c.interest_id.in_(existing_ids),
    )
    already_added = {row[0] for row in (await db.execute(already_stmt)).fetchall()}

    to_insert = existing_ids - already_added
    if to_insert:
        await db.execute(
            user_interests.insert(),
            [{"user_id": current_user.id, "interest_id": i, "weight": 1} for i in to_insert],
        )
        await db.commit()

    return OnboardingCompleteResponse(ok=True, count=len(to_insert))


@router.post(
    "/onboarding/swipe",
    response_model=OnboardingSwipeResponse,
    summary="Записать свайп онбординга",
)
async def onboarding_swipe(
    body: OnboardingSwipeRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    # Validate post exists
    post = await db.get(Post, body.postId)
    if post is None:
        raise HTTPException(status_code=404, detail="Post not found")

    # Upsert swipe record (ignore if already swiped this post)
    existing_swipe_stmt = select(UserSwipedPost).where(
        UserSwipedPost.user_id == current_user.id,
        UserSwipedPost.post_id == body.postId,
    )
    existing_swipe = (await db.execute(existing_swipe_stmt)).scalar_one_or_none()

    if existing_swipe is None:
        swipe = UserSwipedPost(
            user_id=current_user.id,
            post_id=body.postId,
            direction=body.direction,
        )
        db.add(swipe)
        await db.flush()

    # On right swipe: boost weight for each of the post's interests by 1
    if body.direction == "right":
        interest_ids_stmt = select(post_interests.c.interest_id).where(
            post_interests.c.post_id == body.postId
        )
        interest_ids = [row[0] for row in (await db.execute(interest_ids_stmt)).fetchall()]

        for interest_id in interest_ids:
            exists_stmt = select(user_interests.c.weight).where(
                user_interests.c.user_id == current_user.id,
                user_interests.c.interest_id == interest_id,
            )
            row = (await db.execute(exists_stmt)).first()
            if row is not None:
                await db.execute(
                    user_interests.update()
                    .where(
                        user_interests.c.user_id == current_user.id,
                        user_interests.c.interest_id == interest_id,
                    )
                    .values(weight=user_interests.c.weight + 1)
                )
            else:
                await db.execute(
                    user_interests.insert().values(
                        user_id=current_user.id,
                        interest_id=interest_id,
                        weight=1,
                    )
                )

    await db.commit()
    return OnboardingSwipeResponse(ok=True)
