import hmac
from datetime import datetime, timedelta
from typing import Any

from jose import jwt
from app.core.config import settings


def create_access_token(subject: Any) -> str:
    """
    Создает JWT access_token.
    
    :param subject: Идентификатор пользователя (или другие данные), который будет храниться в 'sub' claim.
    """
    expire = datetime.utcnow() + timedelta(
        minutes=settings.access_token_expire_minutes
    )
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(
        to_encode, settings.secret_key, algorithm=settings.algorithm
    )
    return encoded_jwt
