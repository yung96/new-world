from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
from app.core.config import settings

# Инициализация асинхронного движка и фабрики сессий SQLAlchemy.
engine = create_async_engine(settings.db_url, echo=False)
async_session_factory = async_sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False,
    expire_on_commit=False,
)
