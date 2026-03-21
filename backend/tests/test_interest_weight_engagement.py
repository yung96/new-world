import pytest
from sqlalchemy import select

from app.models.associations import user_interests
from app.models.post import Season
from app.services.post_service import PostService
from app.services.review_service import ReviewService
from app.services.social_service import (
    BONUS_INTEREST_WEIGHT_FAVORITE,
    BONUS_INTEREST_WEIGHT_REVIEW,
    MIN_INTEREST_WEIGHT,
    PASSIVE_INTEREST_WEIGHT_DECAY,
    SocialService,
)
from app.services.user_service import get_or_create_user


async def test_favorite_boosts_post_interests_and_decays_others(db_session):
    user = await get_or_create_user(db_session, phone="+79990002001")
    author = await get_or_create_user(db_session, phone="+79990002002")
    social = SocialService(db_session)
    interest_a = await social.create_interest("СпортА", "🪁")
    interest_b = await social.create_interest("ПрогулкаБ", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_a.id)
    await social.add_interest_to_user(user=user, interest_id=interest_b.id)
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_a.id, weight=10
    )
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_b.id, weight=10
    )

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Место",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.summer,
        interest_ids=[interest_a.id],
    )

    await posts.add_favorite(user=user, post_id=post.id)

    weights = await social.get_interest_weights_for_user(user=user)
    assert weights[interest_a.id] == 10 + BONUS_INTEREST_WEIGHT_FAVORITE
    assert weights[interest_b.id] == 10 - PASSIVE_INTEREST_WEIGHT_DECAY


async def test_favorite_idempotent_second_call_does_not_change_weights(db_session):
    user = await get_or_create_user(db_session, phone="+79990002003")
    author = await get_or_create_user(db_session, phone="+79990002004")
    social = SocialService(db_session)
    interest_a = await social.create_interest("КиноА", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_a.id)
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_a.id, weight=5
    )

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Пост",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.summer,
        interest_ids=[interest_a.id],
    )

    await posts.add_favorite(user=user, post_id=post.id)
    after_first = await social.get_interest_weights_for_user(user=user)

    await posts.add_favorite(user=user, post_id=post.id)
    after_second = await social.get_interest_weights_for_user(user=user)

    assert after_first == after_second


async def test_review_applies_review_bonus_and_decay(db_session):
    user = await get_or_create_user(db_session, phone="+79990002005")
    author = await get_or_create_user(db_session, phone="+79990002006")
    social = SocialService(db_session)
    interest_a = await social.create_interest("МузыкаА", "🪁")
    interest_b = await social.create_interest("ТеатрБ", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_a.id)
    await social.add_interest_to_user(user=user, interest_id=interest_b.id)
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_a.id, weight=20
    )
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_b.id, weight=20
    )

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Отзывное место",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.winter,
        interest_ids=[interest_a.id],
    )

    reviews = ReviewService(db_session)
    await reviews.create_review(
        author=user,
        post_id=post.id,
        rating=5,
        comment="ok",
        media_urls=[],
    )

    weights = await social.get_interest_weights_for_user(user=user)
    assert weights[interest_a.id] == 20 + BONUS_INTEREST_WEIGHT_REVIEW
    assert weights[interest_b.id] == 20 - PASSIVE_INTEREST_WEIGHT_DECAY


async def test_review_second_on_same_post_does_not_change_weights(db_session):
    user = await get_or_create_user(db_session, phone="+79990002011")
    author = await get_or_create_user(db_session, phone="+79990002012")
    social = SocialService(db_session)
    interest_a = await social.create_interest("ПовторА", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_a.id)
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_a.id, weight=15
    )

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Два отзыва",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.summer,
        interest_ids=[interest_a.id],
    )

    reviews = ReviewService(db_session)
    await reviews.create_review(
        author=user,
        post_id=post.id,
        rating=5,
        comment="первый",
        media_urls=[],
    )
    after_first = await social.get_interest_weights_for_user(user=user)

    await reviews.create_review(
        author=user,
        post_id=post.id,
        rating=4,
        comment="второй",
        media_urls=[],
    )
    after_second = await social.get_interest_weights_for_user(user=user)

    assert after_first == after_second


async def test_engagement_adds_missing_post_interest_to_user_with_boost(db_session):
    user = await get_or_create_user(db_session, phone="+79990002007")
    author = await get_or_create_user(db_session, phone="+79990002008")
    social = SocialService(db_session)
    interest_a = await social.create_interest("НовыйА", "🪁")
    interest_b = await social.create_interest("СтарыйБ", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_b.id)

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Только А",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.spring,
        interest_ids=[interest_a.id],
    )

    await posts.add_favorite(user=user, post_id=post.id)

    weights = await social.get_interest_weights_for_user(user=user)
    assert weights[interest_a.id] == MIN_INTEREST_WEIGHT + BONUS_INTEREST_WEIGHT_FAVORITE
    # при весе 1 декей не уводит ниже MIN_INTEREST_WEIGHT
    assert weights[interest_b.id] == MIN_INTEREST_WEIGHT


async def test_post_without_interests_only_passive_decay(db_session):
    user = await get_or_create_user(db_session, phone="+79990002009")
    author = await get_or_create_user(db_session, phone="+79990002010")
    social = SocialService(db_session)
    interest_a = await social.create_interest("Первый", "🪁")
    interest_b = await social.create_interest("Второй", "🪁")

    await social.add_interest_to_user(user=user, interest_id=interest_a.id)
    await social.add_interest_to_user(user=user, interest_id=interest_b.id)
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_a.id, weight=8
    )
    await social.set_interest_weight_for_user(
        user=user, interest_id=interest_b.id, weight=8
    )

    posts = PostService(db_session)
    post = await posts.create_post(
        author=author,
        title="Без тегов",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.autumn,
        interest_ids=[],
    )

    await posts.add_favorite(user=user, post_id=post.id)

    weights = await social.get_interest_weights_for_user(user=user)
    expected = 8 - PASSIVE_INTEREST_WEIGHT_DECAY
    assert weights[interest_a.id] == expected
    assert weights[interest_b.id] == expected

    rows = (
        await db_session.execute(
            select(user_interests.c.interest_id).where(
                user_interests.c.user_id == user.id
            )
        )
    ).all()
    assert len(rows) == 2
