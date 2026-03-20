import pytest
from fastapi import HTTPException
from sqlalchemy import select

from app.models.associations import user_interests
from app.services.social_service import SocialService
from app.services.user_service import get_or_create_user


async def test_interest_weight_defaults_to_one_after_binding(db_session):
    user = await get_or_create_user(db_session, phone="+79990001001")
    service = SocialService(db_session)
    interest = await service.create_interest("Вино")

    await service.add_interest_to_user(user=user, interest_id=interest.id)

    row = (
        await db_session.execute(
            select(user_interests.c.weight).where(
                user_interests.c.user_id == user.id,
                user_interests.c.interest_id == interest.id,
            )
        )
    ).one()
    assert row.weight == 1


async def test_set_interest_weight_for_user_updates_value(db_session):
    user = await get_or_create_user(db_session, phone="+79990001002")
    service = SocialService(db_session)
    interest = await service.create_interest("Пешие прогулки")
    await service.add_interest_to_user(user=user, interest_id=interest.id)

    await service.set_interest_weight_for_user(
        user=user, interest_id=interest.id, weight=7
    )

    weights = await service.get_interest_weights_for_user(user=user)
    assert weights[interest.id] == 7


async def test_set_interest_weight_for_unbound_interest_returns_404(db_session):
    user = await get_or_create_user(db_session, phone="+79990001003")
    service = SocialService(db_session)
    interest = await service.create_interest("Активный спорт")

    with pytest.raises(HTTPException) as exc:
        await service.set_interest_weight_for_user(
            user=user, interest_id=interest.id, weight=3
        )

    assert exc.value.status_code == 404
    assert exc.value.detail == "Interest is not bound to user"


async def test_set_interest_weight_for_unknown_interest_returns_404(db_session):
    user = await get_or_create_user(db_session, phone="+79990001004")
    service = SocialService(db_session)

    with pytest.raises(HTTPException) as exc:
        await service.set_interest_weight_for_user(
            user=user, interest_id=999999, weight=10
        )

    assert exc.value.status_code == 404
    assert exc.value.detail == "Interest not found"


async def test_interests_bulk_create(db_session):
    user = await get_or_create_user(db_session, phone="+79990001005")
    service = SocialService(db_session)

    # создаем интересы
    interest1 = await service.create_interest("Кино")
    interest2 = await service.create_interest("Музыка")
    interest3 = await service.create_interest("Спорт")

    # добавляем bulk
    await service.add_interests_to_user(
        user=user,
        interest_ids=[interest1.id, interest2.id, interest3.id],
    )

    # проверяем что все добавились
    rows = (
        await db_session.execute(
            select(user_interests.c.interest_id, user_interests.c.weight).where(
                user_interests.c.user_id == user.id
            )
        )
    ).all()

    assert len(rows) == 3
    ids = {row.interest_id for row in rows}
    assert ids == {interest1.id, interest2.id, interest3.id}

    # проверяем что веса по умолчанию = 1
    for row in rows:
        assert row.weight == 1

    # повторное добавление (не должно создать дубликаты)
    await service.add_interests_to_user(
        user=user,
        interest_ids=[interest1.id, interest2.id],
    )

    rows_after = (
        await db_session.execute(
            select(user_interests.c.interest_id).where(
                user_interests.c.user_id == user.id
            )
        )
    ).all()

    assert len(rows_after) == 3  # без дублей
