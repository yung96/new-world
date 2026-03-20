from datetime import datetime

from fastapi import APIRouter, Depends, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import ConfigDict, Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.base_schema import BasePydanticModel

from app.core.dependencies import get_db_session
from app.models.user import User
from app.services.auth_service import AuthService

# --- Схемы (DTOs) ---

class LoginData(BasePydanticModel):
    phone: str = Field(
        ...,
        min_length=12,
        max_length=12,
        description="Номер телефона пользователя в произвольном формате.",
        examples=["+79991234567"],
        pattern=r"^\+7\d{10}$",
    )


class Token(BasePydanticModel):
    access_token: str
    token_type: str = "bearer"


class UserData(BasePydanticModel):
    id: int
    phone: str
    created_at: datetime

class Token(BasePydanticModel):
    access_token: str = Field(..., description="JWT токен доступа.")
    token_type: str = Field(default="bearer", description="Тип токена.")

class UserData(BasePydanticModel):
    id: int = Field(..., description="Уникальный идентификатор пользователя.")
    phone: str = Field(..., description="Телефон пользователя.")
    created_at: datetime = Field(..., description="Дата и время регистрации пользователя.")


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
    response_description="Успешная авторизация и токен доступа.",)
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


@router.get("/users/me",
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
