"""
Модуль конфигурации приложения.
Использует Pydantic Settings для управления переменными окружения.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field, model_validator


class Settings(BaseSettings):
    """
    Основной класс настроек приложения.
    Все переменные автоматически загружаются из .env файла.
    """
    
    # PostgreSQL настройки
    postgres_db: str = Field(default="digital", description="Название базы данных PostgreSQL")
    postgres_user: str = Field(default="user", description="Пользователь PostgreSQL")
    postgres_password: str = Field(default="password", description="Пароль PostgreSQL")
    
    # URL подключений
    database_url: str = Field(
        default="postgresql+asyncpg://user:password@localhost:5432/digital",
        description="URL для подключения к PostgreSQL через asyncpg"
    )
    redis_url: str = Field(
        default="redis://localhost:6379",
        description="URL для подключения к Redis"
    )
    
    # Telegram Bot
    bot_token: str = Field(
        default="",
        description="Токен Telegram бота от @BotFather"
    )

    quiz_bot_api_token: str = Field(
        default="",
        description="Секрет для авторизации бота квиза при работе с API"
    )
    quiz_answer_similarity_threshold: float = Field(
        default=0.82,
        description="Минимальный порог схожести ответа (0..1) для признания его верным"
    )
    
    # --- JWT Settings ---
    secret_key: str
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 5
    
    # Дополнительные настройки приложения
    debug: bool = Field(default=False, description="Режим отладки")
    
    # Настройки кэширования
    cache_ttl: int = Field(default=3600, description="Время жизни кэша в секундах (по умолчанию 1 час)")

    # Разрешённые Origins фронтенда (CORS), через запятую
    frontend_cors_origins: str = Field(
        default="http://localhost:5173,http://12-7.0.0.1:5173",
        description="Список Origin для фронтенда (через запятую)"
    )

    upload_max_file_size_mb: int = Field(
        default=10,
        description="Максимальный размер загружаемого файла (MB)"
    )
    uploads_gc_interval_seconds: int = Field(
        default=600,
        description="Интервал запуска GC загруженных файлов (сек.)"
    )
    uploads_gc_grace_period_seconds: int = Field(
        default=3600,
        description="Возраст файла (сек.), после которого orphan может быть удален"
    )

    usd_rate_fallback: float = Field(
        default=100.0,
        description="Fallback курс USD->RUB, если ЦБ недоступен"
    )
    usd_rate_cache_ttl_seconds: int = Field(
        default=600,
        description="TTL кэша курса USD ЦБ (сек.)"
    )


    @property
    def frontend_cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.frontend_cors_origins.split(',') if o.strip()]

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore"
    )


# Глобальный экземпляр настроек
settings = Settings()

