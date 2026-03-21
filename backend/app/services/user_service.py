from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import IntegrityError
from sqlalchemy import select

from app.models.user import User


async def get_or_create_user(db_session: AsyncSession, *, phone: str) -> User:
    """Get user by phone or create one."""
    result = await db_session.execute(select(User).where(User.phone == phone))
    user = result.scalar_one_or_none()
    if user is not None:
        return user

    new_user = User(phone=phone)
    db_session.add(new_user)

    try:
        await db_session.commit()
        await db_session.refresh(new_user)
        return new_user
    except IntegrityError:
        await db_session.rollback()
        result = await db_session.execute(select(User).where(User.phone == phone))
        user = result.scalar_one_or_none()
        if user is None:
            raise
        return user
