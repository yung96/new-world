from fastapi import HTTPException, status
from jose import jwt, JWTError
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.config import settings
from app.core.security import create_access_token
from app.models.user import User
from app.services.user_service import get_or_create_user


class AuthService:
    def __init__(self, db_session: AsyncSession):
        self.db = db_session


    def normilize_phone(self, phone: str) -> str:
        return phone.strip()

    async def login(self, phone: str) -> str:
        normalized_phone = self.normilize_phone(phone)
        if not normalized_phone:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Phone must not be empty",
            )

        user = await get_or_create_user(
            self.db,
            phone=normalized_phone,
        )

        access_token = create_access_token(subject=user.id)
        return access_token

    async def get_user_from_token(self, token: str) -> User:
        credentials_exception = HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
        try:
            payload = jwt.decode(
                token, settings.secret_key, algorithms=[settings.algorithm]
            )
            user_id = payload.get("sub")
            if user_id is None:
                raise credentials_exception
            user_id_int = int(user_id)
        except JWTError:
            raise credentials_exception
        except (TypeError, ValueError):
            raise credentials_exception

        user = await self.db.get(User, user_id_int)
        if user is None:
            raise credentials_exception
        return user

    async def touch_user(self, user: User) -> None:
        """No-op hook for future auth side effects."""
        _ = user
