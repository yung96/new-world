from contextlib import asynccontextmanager, suppress
import asyncio
from fastapi import FastAPI
import httpx
import redis.asyncio as redis
from app.core.config import settings
from app.db import engine, async_session_factory
from app.models import Base
from app.services.uploads_gc import uploads_gc_loop
from app.services.scheduler import Scheduler
from app.services.jobs import recalc_post_ratings, cleanup_stale_uploads, refresh_weather_cache, refresh_transport_prices
from loguru import logger


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Запуск контекстного менеджера")

    # Инициализируем схему БД, если миграции/таблицы ещё не применены.
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    # 1. Создание клиента httpx
    http_client = httpx.AsyncClient(
        timeout=httpx.Timeout(30.0, connect=10.0),
        limits=httpx.Limits(max_connections=100, max_keepalive_connections=20),
        follow_redirects=True
    )

    # 2. Создание пула соединений Redis
    redis_client = redis.from_url(
        settings.redis_url,
        encoding="utf-8",
        decode_responses=True
    )

    # 3. Создание движка и фабрики сессий SQLAlchemy
    db_engine = engine
    db_session_factory = async_session_factory

    # Сохраняем клиенты в состояние приложения
    app.state.http_client = http_client
    app.state.redis_client = redis_client
    app.state.db_session_factory = db_session_factory

    app.state.uploads_gc_task = asyncio.create_task(
        uploads_gc_loop(
            interval_seconds=settings.uploads_gc_interval_seconds,
            grace_period_seconds=settings.uploads_gc_grace_period_seconds,
        )
    )

    # Scheduler
    scheduler = Scheduler()
    scheduler.add("recalc_ratings", recalc_post_ratings, interval=300, run_at_start=False)   # каждые 5 мин
    scheduler.add("cleanup_uploads", cleanup_stale_uploads, interval=3600)                    # каждый час
    scheduler.add("refresh_weather", refresh_weather_cache, interval=86400, run_at_start=True) # раз в день
    scheduler.add("refresh_transport", refresh_transport_prices, interval=86400)               # раз в день
    scheduler.start()
    app.state.scheduler = scheduler

    yield

    logger.info("Приложение останавливается...")

    await app.state.scheduler.stop()

    task = getattr(app.state, "uploads_gc_task", None)
    if task is not None:
        task.cancel()
        with suppress(asyncio.CancelledError):
            await task

    await app.state.http_client.aclose()
    await app.state.redis_client.aclose()
    await db_engine.dispose()


    print("Все контексты закрыты")
