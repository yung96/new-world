from app.models.post import Season
from app.models.review import Review
from app.services.feed_service import FeedService
from app.services.post_service import PostService
from app.services.social_service import SocialService
from app.services.user_service import get_or_create_user


async def test_feed_total_matches_all_posts(db_session):
    u = await get_or_create_user(db_session, phone="+79990003001")
    a = await get_or_create_user(db_session, phone="+79990003002")
    social = SocialService(db_session)
    posts = PostService(db_session)

    intr = await social.create_interest("ФидТотал", "🪁")
    await posts.create_post(
        author=a,
        title="P1",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.spring,
        interest_ids=[intr.id],
    )
    await posts.create_post(
        author=a,
        title="P2",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.spring,
        interest_ids=[intr.id],
    )

    rows, total = await FeedService(db_session).list_feed(user=u, page=1, page_size=10)
    assert total == 2
    assert len(rows) == 2


async def test_feed_prioritizes_high_weight_interest_match(db_session):
    user = await get_or_create_user(db_session, phone="+79990003003")
    author = await get_or_create_user(db_session, phone="+79990003004")
    social = SocialService(db_session)
    posts = PostService(db_session)

    ia = await social.create_interest("ВесА", "🪁")
    ib = await social.create_interest("ВесБ", "🪁")
    await social.add_interest_to_user(user=user, interest_id=ia.id)
    await social.add_interest_to_user(user=user, interest_id=ib.id)
    await social.set_interest_weight_for_user(user=user, interest_id=ia.id, weight=50)
    await social.set_interest_weight_for_user(user=user, interest_id=ib.id, weight=1)

    post_match_a = await posts.create_post(
        author=author,
        title="ТолькоА",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.summer,
        interest_ids=[ia.id],
    )
    await posts.create_post(
        author=author,
        title="ТолькоБ",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.summer,
        interest_ids=[ib.id],
    )

    rows, _ = await FeedService(db_session).list_feed(user=user, page=1, page_size=1)
    assert rows[0][0].id == post_match_a.id


async def test_feed_works_without_user_interests(db_session):
    user = await get_or_create_user(db_session, phone="+79990003005")
    author = await get_or_create_user(db_session, phone="+79990003006")
    social = SocialService(db_session)
    posts = PostService(db_session)
    intr = await social.create_interest("БезЮзера", "🪁")
    await posts.create_post(
        author=author,
        title="Один",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.winter,
        interest_ids=[intr.id],
    )

    rows, total = await FeedService(db_session).list_feed(user=user, page=1, page_size=5)
    assert total == 1
    assert len(rows) == 1


async def test_feed_includes_popular_signal(db_session):
    user = await get_or_create_user(db_session, phone="+79990003007")
    author = await get_or_create_user(db_session, phone="+79990003008")
    social = SocialService(db_session)
    posts = PostService(db_session)

    i1 = await social.create_interest("Поп1", "🪁")
    i2 = await social.create_interest("Поп2", "🪁")
    await social.add_interest_to_user(user=user, interest_id=i1.id)

    p_niche = await posts.create_post(
        author=author,
        title="Ниша",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.autumn,
        interest_ids=[i1.id, i2.id],
    )
    p_hot = await posts.create_post(
        author=author,
        title="Много отзывов",
        description=None,
        geo_lat=None,
        geo_lng=None,
        media_urls=[],
        season=Season.autumn,
        interest_ids=[i2.id],
    )
    for _ in range(5):
        db_session.add(
            Review(
                author_id=user.id,
                post_id=p_hot.id,
                rating=5,
                comment=None,
                media_urls=[],
            )
        )
    await db_session.commit()

    ids = set()
    for page in range(1, 4):
        rows, _ = await FeedService(db_session).list_feed(user=user, page=page, page_size=10)
        ids.update(r[0].id for r in rows)

    assert p_hot.id in ids
    assert p_niche.id in ids
