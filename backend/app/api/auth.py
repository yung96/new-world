from datetime import datetime

from fastapi import APIRouter, Depends, status
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.dependencies import get_db_session
from app.models.user import User
from app.services.auth_service import AuthService

# --- Схемы (DTOs) ---

class InitData(BaseModel):
    phone: str = Field(
        ...,
        description="Номер телефона пользователя в произвольном формате.",
        examples=["+79991234567"],
    )

    model_config = ConfigDict(
        json_schema_extra={
            "example": {
                "phone": "+79991234567",
            }
        }
    )

class Token(BaseModel):
    access_token: str = Field(..., description="JWT токен доступа.")
    token_type: str = Field(default="bearer", description="Тип токена.")

class UserData(BaseModel):
    id: int = Field(..., description="Уникальный идентификатор пользователя.")
    phone: str = Field(..., description="Телефон пользователя.")
    created_at: datetime = Field(..., description="Дата и время регистрации пользователя.")

    model_config = ConfigDict(from_attributes=True)


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
    auth_service: AuthService = Depends(get_auth_service)
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
async def login_for_access_token(
    data: InitData, auth_service: AuthService = Depends(get_auth_service)
):
    """
    Авторизация по номеру телефона.
    """
    access_token = await auth_service.login_and_get_token(data.phone)
    return {"access_token": access_token}


@router.get(
    "/users/me",
    response_model=UserData,
    summary="Профиль текущего пользователя",
    description="Возвращает данные пользователя, определенного по Bearer токену.",
    response_description="Профиль авторизованного пользователя.",
)
async def read_users_me(current_user: User = Depends(get_current_user)):
    """
    Возвращает информацию о текущем авторизованном пользователе.
    """
    return current_user


