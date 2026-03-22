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
    DB_USER: str | None = None
    DB_PASS: str | None = None
    DB_HOST: str | None = None
    DB_PORT: int | None = None
    DB_NAME: str | None = None
    database_url: str | None = Field(
        default=None,
        description="Полный URL БД (приоритетный источник, напр. DATABASE_URL)",
    )

    @computed_field
    @property
    def db_url(self) -> str:
        if self.database_url:
            return self.database_url

        user = self.DB_USER or self.POSTGRES_USER
        password = self.DB_PASS or self.POSTGRES_PASSWORD
        host = self.DB_HOST or "localhost"
        port = self.DB_PORT or 5432
        name = self.DB_NAME or self.POSTGRES_DB

        if not all([user, password, name]):
            raise ValueError(
                "Database config is incomplete. Set DATABASE_URL or DB_* (or POSTGRES_* pair with host/port)."
            )
        return f"postgresql+asyncpg://{user}:{password}@{host}:{port}/{name}"

    # Совместимость с docker-compose, где обычно задаются POSTGRES_*
    POSTGRES_USER: str | None = None
    POSTGRES_PASSWORD: str | None = None
    POSTGRES_DB: str | None = None

    redis_url: str = Field(
        default="redis://localhost:6379",
        description="URL для подключения к Redis",
    )

    # --- JWT Settings ---
    secret_key: str
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 1440  # 24h for hackathon

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

    GPT_CLIENT_BASE_URL: str | None = Field(
        default=None, description="Базовый URL GPT-клиента (опционально для MVP)"
    )
    GPT_CLIENT_KEY: str | None = Field(
        default=None, description="API-ключ GPT-клиента (опционально для MVP)"
    )
    GPT_MODEL: str = Field(default="gpt-4o-mini", description="Модель GPT по умолчанию")

    IVAN_ALT_TEST_SECRET: str | None = Field(
        default=None,
        description=(
            "Опционально: если задан — POST …/ivan-alt/local-routes/test-run только с заголовком "
            "X-Ivan-Alt-Test-Secret (для публичного API). Если не задан — E2E доступен без секрета."
        ),
    )

    def ivan_alt_test_run_authorized(self, header_secret: str | None) -> bool:
        if self.IVAN_ALT_TEST_SECRET:
            return header_secret == self.IVAN_ALT_TEST_SECRET
        return True

    TRAVEL_API_KEY: str = Field(description="API TRAVEL для глобального подбора рейсов")
    TGIS_API_KEY: str = Field(description="API 2GIS")
    DADATA_API_KEY: str = Field(description="API DaData")

    @property
    def frontend_cors_origins_list(self) -> list[str]:
        return [o.strip() for o in self.frontend_cors_origins.split(",") if o.strip()]

    @property
    def api_mount_path(self) -> str:
        """Префикс монтирования API в URL (документация, HTML-панели). По умолчанию `/api`."""
        return "/api"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",
    )


# Глобальный экземпляр настроек
settings = Settings()
