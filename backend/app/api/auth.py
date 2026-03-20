from datetime import datetime

from fastapi import APIRouter, Depends
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
        description="Номер телефона",
        examples=["+71234567890"],
        pattern=r"^\+7\d{10}$",
    )


class Token(BasePydanticModel):
    access_token: str
    token_type: str = "bearer"


class UserData(BasePydanticModel):
    id: int
    phone: str
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)


# --- Настройка FastAPI ---

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/auth")


# --- Зависимости ---


def get_auth_service(db: AsyncSession = Depends(get_db_session)) -> AuthService:
    return AuthService(db)


async def get_current_user(
    token: str = Depends(oauth2_scheme),
    auth_service: AuthService = Depends(get_auth_service),
) -> User:
    return await auth_service.get_user_from_token(token)


# --- Роуты ---


@router.post("/auth", response_model=Token)
async def login(
    data: LoginData,
    auth_service: AuthService = Depends(get_auth_service),
):
    """
    Авторизация по номеру телефона.
    """
    access_token = await auth_service.login(data.phone)
    return {"access_token": access_token}


@router.get("/users/me", response_model=UserData)
async def get_user(current_user: User = Depends(get_current_user)):
    """
    Возвращает информацию о текущем авторизованном пользователе.
    """
    return current_user
