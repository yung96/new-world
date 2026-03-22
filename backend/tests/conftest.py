import sys
import os
from pathlib import Path

# Добавляем корень backend в sys.path
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import pytest
import pytest_asyncio
from alembic import command
from alembic.config import Config
from httpx import ASGITransport, AsyncClient
from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker

_BASE_DIR = Path(__file__).resolve().parents[1]

_db_name = os.environ.get("POSTGRES_DB_TEST", "db_test")
_db_user = os.environ.get("POSTGRES_USER_TEST", "user_test")
_db_password = os.environ.get("POSTGRES_PASSWORD_TEST", "password_test")
_db_host = os.environ.get("TEST_DB_HOST", "kraeved_test_postgres")
_db_port = os.environ.get("TEST_DB_PORT", "5432")

os.environ.setdefault(
    "DATABASE_URL",
    f"postgresql+asyncpg://{_db_user}:{_db_password}@{_db_host}:{_db_port}/{_db_name}",
)
os.environ.setdefault("REDIS_URL", "redis://kraeved_test_redis:6379")
os.environ.setdefault("SECRET_KEY", "test-secret")
os.environ.setdefault("ACCESS_TOKEN_EXPIRE_MINUTES", "5")
os.environ.setdefault("IVAN_ALT_TEST_SECRET", "test-ivan-e2e-panel")

from app.core.config import settings
from app.models import Base


@pytest.fixture(autouse=True)
def disable_real_gpt_in_tests(monkeypatch):
    """Не вызываем внешний GPT из тестов (.env.test может содержать боевой ключ)."""
    monkeypatch.setattr(settings, "GPT_CLIENT_KEY", "fake")


@pytest_asyncio.fixture(scope="session", autouse=True)
async def apply_migrations():
    engine = create_async_engine(settings.db_url, echo=False)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.drop_all)
        await conn.run_sync(Base.metadata.create_all)
    await engine.dispose()
    yield


@pytest_asyncio.fixture
async def db_session():
    engine = create_async_engine(settings.db_url, echo=False)
    session_factory = async_sessionmaker(engine, expire_on_commit=False)
    async with session_factory() as session:
        yield session
    await engine.dispose()


@pytest_asyncio.fixture(autouse=True)
async def clean_database():
    engine = create_async_engine(settings.db_url, echo=False)
    async with engine.begin() as conn:
        for table in reversed(Base.metadata.sorted_tables):
            await conn.execute(
                text(f'TRUNCATE TABLE "{table.name}" RESTART IDENTITY CASCADE')
            )
    await engine.dispose()
    yield


@pytest_asyncio.fixture
async def client():
    from main import app as fastapi_app

    # Важно: при голом ASGITransport lifespan (startup/shutdown) может не запускаться,
    # из-за чего не инициализируются app.state.* зависимости (например db_session_factory).
    async with fastapi_app.router.lifespan_context(fastapi_app):
        transport = ASGITransport(app=fastapi_app)
        async with AsyncClient(transport=transport, base_url="http://test") as ac:
            yield ac
