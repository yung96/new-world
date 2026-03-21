from datetime import datetime

from fastapi import APIRouter, Depends, Query, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel

from app.core.dependencies import get_db_session
from app.models.review import Review
from app.models.user import User
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
    postCity: str = Field(description="Город места.")
    rating: int = Field(description="Оценка 1–5.")
    comment: str | None = Field(description="Текст отзыва.")
    mediaUrls: list[str] = Field(description="Медиа отзыва.")
    createdAt: datetime = Field(description="Время публикации отзыва.")


class UserPublicProfileResponse(BasePydanticModel):
    id: int
    phone: str = Field(description="Телефон пользователя (как в других compact-ответах).")
    followersCount: int = Field(description="Число подписчиков (кто подписан на этого пользователя).")
    reviews: list[UserPublicReviewItem]
    total: int = Field(description="Общее число отзывов автора (для пагинации).")
    page: int
    pageSize: int


def _city_or_empty(value: str | None) -> str:
    return (value or "").strip()


def _review_to_public_item(review: Review) -> UserPublicReviewItem:
    return UserPublicReviewItem(
        id=review.id,
        postId=review.post_id,
        postTitle=review.post.title,
        postCity=_city_or_empty(review.post.city),
        rating=review.rating,
        comment=review.comment,
        mediaUrls=list(review.media_urls or []),
        createdAt=review.created_at,
    )


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
    return UserPublicProfileResponse(
        id=user.id,
        phone=user.phone,
        followersCount=followers_count,
        reviews=[_review_to_public_item(r) for r in reviews],
        total=total,
        page=page,
        pageSize=pageSize,
    )
