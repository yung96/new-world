from __future__ import annotations

import hashlib
from datetime import datetime, timezone

from sqlalchemy import and_, func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.associations import UserPlaceStatus, post_interests, user_interests, user_subscriptions
from app.models.post import Post
from app.models.review import Review
from app.models.user import User
from app.services.post_service import PostService
from app.services.social_service import SocialService

# Окно последних постов, внутри которого считаем ленту (пагинация — срез общего merge).
CANDIDATE_POST_LIMIT = 500

# Веса популярности: избранное, отзывы, средний рейтинг
W_FAVORITES = 3.0
W_REVIEWS = 2.0
W_AVG_RATING = 5.0

def _feed_seed(user_id: int, page: int) -> int:
    """Детерминированный seed для псевдослучайного порядка (стабильно при повторном запросе)."""
    day = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    raw = f"{user_id}:{page}:{day}".encode()
    return int.from_bytes(hashlib.sha256(raw).digest()[:8], "big") % (2**31)


def _det_shuffle(post_ids: list[int], seed: int) -> list[int]:
    return sorted(post_ids, key=lambda pid: ((pid * 7919 + seed) % 1000003, pid))


class FeedService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def list_subscription_activity(
        self,
        *,
        user: User,
        page: int,
        page_size: int,
    ) -> tuple[list[Review], int]:
        offset = (page - 1) * page_size
        join_cond = and_(
            user_subscriptions.c.following_id == Review.author_id,
            user_subscriptions.c.follower_id == user.id,
        )
        total_stmt = select(func.count(Review.id)).select_from(Review).join(
            user_subscriptions, join_cond
        )
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)
        stmt = (
            select(Review)
            .join(user_subscriptions, join_cond)
            .options(selectinload(Review.author), selectinload(Review.post))
            .order_by(Review.created_at.desc(), Review.id.desc())
            .offset(offset)
            .limit(page_size)
        )
        items = (await self.db.execute(stmt)).scalars().all()
        return list(items), total

    async def list_feed(
        self,
        *,
        user: User,
        page: int,
        page_size: int,
        exclude_post_ids: set[int] | None = None,
    ) -> tuple[list[tuple[Post, float | None]], int]:
        exclude_post_ids = exclude_post_ids or set()

        total_stmt = select(func.count(Post.id))
        if exclude_post_ids:
            total_stmt = total_stmt.where(Post.id.not_in(exclude_post_ids))
        total = int((await self.db.execute(total_stmt)).scalar_one() or 0)

        if page_size <= 0 or total == 0:
            return [], total

        social = SocialService(self.db)
        weights = await social.get_interest_weights_for_user(user=user)

        cand_stmt = (
            select(Post.id, Post.created_at)
            .order_by(Post.created_at.desc(), Post.id.desc())
            .limit(CANDIDATE_POST_LIMIT)
        )
        cand_rows = (await self.db.execute(cand_stmt)).all()
        candidate_ids = [
            int(r.id) for r in cand_rows if int(r.id) not in exclude_post_ids
        ]
        created = {int(r.id): r.created_at for r in cand_rows}

        if not candidate_ids:
            return [], total

        personal_map = await self._personal_scores(user.id, candidate_ids)
        fav_map, rev_map, avg_map = await self._engagement_maps(candidate_ids)

        def popularity(pid: int) -> float:
            fc = fav_map.get(pid, 0)
            rc = rev_map.get(pid, 0)
            ar = float(avg_map[pid]) if pid in avg_map else 0.0
            return fc * W_FAVORITES + rc * W_REVIEWS + ar * W_AVG_RATING

        pop_by_id = {pid: popularity(pid) for pid in candidate_ids}

        # Персональный пул: по сумме весов, затем свежесть
        if weights:
            personal_ordered = sorted(
                candidate_ids,
                key=lambda pid: (-personal_map.get(pid, 0), -created[pid].timestamp(), -pid),
            )
        else:
            personal_ordered = sorted(
                candidate_ids,
                key=lambda pid: (-created[pid].timestamp(), -pid),
            )

        popular_ordered = sorted(
            candidate_ids,
            key=lambda pid: (-pop_by_id[pid], -created[pid].timestamp(), -pid),
        )
        niche_ordered = sorted(
            candidate_ids,
            key=lambda pid: (pop_by_id[pid], created[pid].timestamp(), pid),
        )

        seed = _feed_seed(user.id, page)
        explore_ordered = _det_shuffle(list(candidate_ids), seed)

        merged = self._weighted_interleave(
            [personal_ordered, popular_ordered, niche_ordered, explore_ordered],
            max_len=len(candidate_ids),
        )

        offset = (page - 1) * page_size
        if offset >= len(merged):
            if exclude_post_ids:
                return [], total
            return await PostService(self.db).list_posts(page=page, page_size=page_size)

        window = merged[offset : offset + page_size]

        if len(window) < page_size:
            fallback = await self._chronological_ids_excluding(
                exclude=set(window) | exclude_post_ids,
                need=page_size - len(window),
                skip=offset + len(merged),
            )
            window = (window + fallback)[:page_size]

        posts = await self._load_posts_ordered(window)
        return posts, total

    async def _personal_scores(self, user_id: int, candidate_ids: list[int]) -> dict[int, int]:
        if not candidate_ids:
            return {}
        stmt = (
            select(post_interests.c.post_id, func.sum(user_interests.c.weight).label("score"))
            .join(
                user_interests,
                (user_interests.c.interest_id == post_interests.c.interest_id)
                & (user_interests.c.user_id == user_id),
            )
            .where(post_interests.c.post_id.in_(candidate_ids))
            .group_by(post_interests.c.post_id)
        )
        rows = (await self.db.execute(stmt)).all()
        return {int(r.post_id): int(r.score or 0) for r in rows}

    async def _engagement_maps(
        self, candidate_ids: list[int]
    ) -> tuple[dict[int, int], dict[int, int], dict[int, float]]:
        if not candidate_ids:
            return {}, {}, {}

        fav_stmt = (
            select(UserPlaceStatus.post_id, func.count().label("fav_cnt"))
            .where(UserPlaceStatus.post_id.in_(candidate_ids))
            .group_by(UserPlaceStatus.post_id)
        )
        fav_rows = (await self.db.execute(fav_stmt)).all()
        fav_map = {int(r.post_id): int(r.fav_cnt) for r in fav_rows}

        rev_stmt = (
            select(
                Review.post_id,
                func.count().label("cnt"),
                func.avg(Review.rating).label("avg_r"),
            )
            .where(Review.post_id.in_(candidate_ids))
            .group_by(Review.post_id)
        )
        rev_rows = (await self.db.execute(rev_stmt)).all()
        rev_map = {int(r.post_id): int(r.cnt) for r in rev_rows}
        avg_map = {int(r.post_id): float(r.avg_r) for r in rev_rows if r.avg_r is not None}

        return fav_map, rev_map, avg_map

    def _weighted_interleave(
        self, pools: list[list[int]], max_len: int
    ) -> list[int]:
        """Чередование пулов: персональный дважды за цикл (~40%), затем популярный, ниша, explore."""
        pattern = [0, 0, 1, 2, 3]
        seen: set[int] = set()
        out: list[int] = []
        idx = [0] * len(pools)
        while len(out) < max_len:
            progressed = False
            for pi in pattern:
                while idx[pi] < len(pools[pi]):
                    pid = pools[pi][idx[pi]]
                    idx[pi] += 1
                    if pid not in seen:
                        seen.add(pid)
                        out.append(pid)
                        progressed = True
                        break
            if not progressed:
                break
        return out

    async def _chronological_ids_excluding(
        self, *, exclude: set[int], need: int, skip: int
    ) -> list[int]:
        if need <= 0:
            return []
        stmt = (
            select(Post.id)
            .order_by(Post.created_at.desc(), Post.id.desc())
            .offset(skip)
            .limit(need + len(exclude) + 50)
        )
        rows = (await self.db.execute(stmt)).scalars().all()
        out: list[int] = []
        for pid in rows:
            if pid in exclude:
                continue
            out.append(pid)
            if len(out) >= need:
                break
        return out

    async def _load_posts_ordered(
        self, post_ids: list[int]
    ) -> list[tuple[Post, float | None]]:
        if not post_ids:
            return []

        rating_subquery = (
            select(
                Review.post_id.label("post_id"),
                func.avg(Review.rating).label("avg_rating"),
            )
            .group_by(Review.post_id)
            .subquery()
        )
        stmt = (
            select(Post, rating_subquery.c.avg_rating)
            .where(Post.id.in_(post_ids))
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .options(selectinload(Post.interests))
        )
        rows = (await self.db.execute(stmt)).all()
        by_id: dict[int, tuple[Post, float | None]] = {}
        for post, avg_r in rows:
            by_id[post.id] = (post, float(avg_r) if avg_r is not None else None)
        return [by_id[pid] for pid in post_ids if pid in by_id]
