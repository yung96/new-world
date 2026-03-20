"""
Модуль конфигурации приложения.
Использует Pydantic Settings для управления переменными окружения.
"""

from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field, computed_field


class Settings(BaseSettings):
    """
    Основной класс настроек приложения.
    Все переменные автоматически загружаются из .env файла.
    """

    # База данных
    DB_USER: str
    DB_PASS: str
    DB_HOST: str
    DB_PORT: int
    DB_NAME: str

    @computed_field
    @property
    def db_url(self) -> str:
        return f"postgresql+asyncpg://{self.DB_USER}:{self.DB_PASS}@{self.DB_HOST}:{self.DB_PORT}/{self.DB_NAME}"

    redis_url: str = Field(
        default="redis://localhost:6379",
        description="URL для подключения к Redis",
    )

    # --- JWT Settings ---
    secret_key: str
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 5
    admin_api_key: str = Field(
        default="dev-admin-key",
        description="Ключ для доступа к обезличенным admin endpoint-ам (X-Admin-Key)",
    )

    # Дополнительные настройки приложения
    debug: bool = Field(default=False, description="Режим отладки")

    # Разрешённые Origins фронтенда (CORS), через запятую
    frontend_cors_origins: str = Field(
        default="http://localhost:5173,http://12-7.0.0.1:5173",
        description="Список Origin для фронтенда (через запятую)",
    )

    upload_max_file_size_mb: int = Field(
        default=10, description="Максимальный размер загружаемого файла (MB)"
    )
    uploads_gc_interval_seconds: int = Field(
        default=600, description="Интервал запуска GC загруженных файлов (сек.)"
    )
    uploads_gc_grace_period_seconds: int = Field(
        default=3600,
        description="Возраст файла (сек.), после которого orphan может быть удален",
    )

    @property
    def frontend_cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.frontend_cors_origins.split(",") if o.strip()]

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )


# Глобальный экземпляр настроек
settings = Settings()
