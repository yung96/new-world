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


def verify_quiz_bot_token(token: str | None) -> bool:
    """
    Простая проверка сервисного токена бота квиза.
    """
    if not token:
        return False
    expected = settings.quiz_bot_api_token
    if not expected:
        return False
    return hmac.compare_digest(token, expected)
