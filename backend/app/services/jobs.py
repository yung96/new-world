"""
Background jobs for the scheduler.
Each job is an async function with no arguments.
DB session is created inside each job (not from request context).
"""

from sqlalchemy import select, func, update
from loguru import logger

from app.db import async_session_factory
from app.models.post import Post
from app.models.review import Review


async def recalc_post_ratings() -> None:
    """Пересчёт rating_avg и reviews_count для всех постов."""
    async with async_session_factory() as db:
        stmt = (
            select(
                Review.post_id,
                func.avg(Review.rating).label("avg"),
                func.count(Review.id).label("cnt"),
            )
            .group_by(Review.post_id)
        )
        result = await db.execute(stmt)
        rows = result.all()

        for post_id, avg_rating, count in rows:
            await db.execute(
                update(Post)
                .where(Post.id == post_id)
                .values(rating_avg=round(float(avg_rating), 2), reviews_count=count)
            )
        await db.commit()
        logger.info("[job] recalc_post_ratings: updated {} posts", len(rows))


async def cleanup_stale_uploads() -> None:
    """Заглушка: очистка осиротевших файлов из uploads/."""
    # TODO: сканировать uploads/, удалять файлы не привязанные к post_media
    pass


async def refresh_weather_cache() -> None:
    """Заглушка: обновление weather_monthly из OpenMeteo."""
    # TODO: для каждого GeoRegion с centroid — запрос Open-Meteo, обновление weather_monthly
    pass


async def refresh_transport_prices() -> None:
    """Заглушка: обновление цен Aviasales/Tutu в transport_links."""
    # TODO: для каждого TransportLink — запрос Travelpayouts, обновление price_from
    pass
