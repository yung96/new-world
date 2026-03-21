from __future__ import annotations

import json
import re
from dataclasses import dataclass
from datetime import date
from typing import Any

from loguru import logger
from sqlalchemy import func, or_, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.api import posts as posts_api
from app.core.config import settings
from app.models.associations import post_interests, user_interests
from app.models.interest import Interest
from app.models.post import Post
from app.models.review import Review
from app.models.user import User
from app.schemas.travel_plan_llm import TravelPlanBlockLlm, TravelPlanDayLlm, TravelPlanLlmOut
from app.services.gpt_service import GptService
from app.services.social_service import SocialService
from app.services.travel_service import TravelService


def _normalize_city_key(name: str) -> str:
    s = (name or "").strip().lower()
    s = s.replace("ё", "е")
    s = re.sub(r"\s+", " ", s)
    return s


# Примерные центры (lat, lon) для геокодинга без внешнего API
CITY_CENTERS: dict[str, tuple[float, float]] = {
    "москва": (55.7558, 37.6173),
    "санкт-петербург": (59.9343, 30.3351),
    "краснодар": (45.0355, 38.9753),
    "казань": (55.7963, 49.1088),
    "новосибирск": (55.0084, 82.9357),
    "екатеринбург": (56.8389, 60.6057),
    "нижний новгород": (56.2965, 43.9361),
    "сочи": (43.6028, 39.7342),
    "ростов-на-дону": (47.2357, 39.7015),
}


def resolve_city_center(city_name: str) -> tuple[float, float] | None:
    key = _normalize_city_key(city_name)
    if key in CITY_CENTERS:
        return CITY_CENTERS[key]
    for k, v in CITY_CENTERS.items():
        if k in key or key in k:
            return v
    return None


TRAVEL_PLAN_SYSTEM_PROMPT = """Ты планируешь поездку в приложении «Краевед»: есть места из нашей базы (карточки постов) и внешние точки из 2GIS (кафе, парки и т.д.).

Правила:
1) Места из базы: используй ТОЛЬКО post_id из массива internalPosts. Не выдумывай новые id.
2) Внешние точки: используй ТОЛЬКО индекс external_candidate_index из массива externalCandidates (это поле externalIndex).
3) Перелёты: если есть flightOffers, блок flight ссылается на flight_offer_index — индекс в этом массиве.
4) Интересы пользователя в userInterests: у каждого есть id, name, weight. Чем больше weight, тем важнее интерес. В тексте intro и в rationale ОБЯЗАТЕЛЬНО связывай выбор мест с интересами: например «Знаем, что вам близки прогулки с детьми (высокий вес) — вот площадка…». Для каждого блока заполни highlighted_interest_ids — какие id интересов лучше объясняют выбор (для внешних точек назначь 1–3 id из списка пользователя по смыслу).
5) block_type free_time — свободное время или перерыв; без post_id и без external_candidate_index.
6) Сначала спланируй глобальный этап (перелёт или дорога), затем дни в городе назначения. Соблюдай day_index подряд с 1.
7) Ответ — структура по схеме (без markdown, без комментариев вне JSON). Язык: русский."""


@dataclass
class TravelPlanBuildResult:
    intro: str
    resolved_mode: str
    warnings: list[str]
    flight_offers: list[dict[str, Any]]
    external_catalog: list[dict[str, Any]]
    days: list[dict[str, Any]]
    used_llm: bool


class TravelPlanService:
    def __init__(
        self,
        db: AsyncSession,
        *,
        travel: TravelService | None = None,
    ):
        self.db = db
        self.travel = travel or TravelService()

    async def _interest_scores_for_posts(
        self, user_id: int, post_ids: list[int]
    ) -> dict[int, int]:
        if not post_ids:
            return {}
        stmt = (
            select(post_interests.c.post_id, func.sum(user_interests.c.weight).label("score"))
            .join(
                user_interests,
                (user_interests.c.interest_id == post_interests.c.interest_id)
                & (user_interests.c.user_id == user_id),
            )
            .where(post_interests.c.post_id.in_(post_ids))
            .group_by(post_interests.c.post_id)
        )
        rows = (await self.db.execute(stmt)).all()
        return {int(r.post_id): int(r.score or 0) for r in rows}

    async def _load_destination_posts(
        self,
        *,
        dest_city: str,
        dest_lat: float,
        dest_lon: float,
        limit: int = 40,
    ) -> list[tuple[Post, float | None]]:
        delta = 0.65
        lat_min, lat_max = dest_lat - delta, dest_lat + delta
        lon_min, lon_max = dest_lon - delta, dest_lon + delta
        city_term = f"%{dest_city.strip()}%"

        rating_subquery = (
            select(
                Review.post_id.label("post_id"),
                func.avg(Review.rating).label("avg_rating"),
            )
            .group_by(Review.post_id)
            .subquery()
        )

        geo_clause = (
            Post.geo_lat.isnot(None)
            & Post.geo_lng.isnot(None)
            & Post.geo_lat.between(lat_min, lat_max)
            & Post.geo_lng.between(lon_min, lon_max)
        )
        city_clause = Post.city.ilike(city_term)

        stmt = (
            select(Post, rating_subquery.c.avg_rating)
            .outerjoin(rating_subquery, rating_subquery.c.post_id == Post.id)
            .where(or_(geo_clause, city_clause))
            .options(selectinload(Post.interests))
            .order_by(Post.created_at.desc())
            .limit(limit)
        )
        rows = (await self.db.execute(stmt)).all()
        return [(r[0], float(r[1]) if r[1] is not None else None) for r in rows]

    async def _user_interests_payload(self, user: User) -> list[dict[str, Any]]:
        social = SocialService(self.db)
        weights = await social.get_interest_weights_for_user(user=user)
        if not weights:
            return []
        stmt = select(Interest).where(Interest.id.in_(weights.keys()))
        interests = (await self.db.execute(stmt)).scalars().all()
        by_id = {i.id: i for i in interests}
        out = []
        for iid, w in sorted(weights.items(), key=lambda x: -x[1]):
            intr = by_id.get(iid)
            if intr is None:
                continue
            out.append({"interestId": iid, "name": intr.name, "weight": w})
        return out

    async def _fetch_flights_safe(
        self,
        *,
        origin: str,
        destination: str,
        departure_at: str | None,
        return_at: str | None,
    ) -> tuple[list[dict[str, Any]], list[str]]:
        warns: list[str] = []
        params: dict[str, Any] = {
            "origin": origin,
            "destination": destination,
            "one_way": True,
            "direct": False,
            "currency": "rub",
            "market": "ru",
            "limit": 8,
            "page": 1,
            "sorting": "price",
        }
        if departure_at:
            params["departure_at"] = departure_at
        if return_at:
            params["return_at"] = return_at
        try:
            raw = await self.travel.get_global_route(params)
        except Exception as e:
            logger.warning("travel flights failed: {}", e)
            return [], [f"Не удалось получить авиабилеты: {e}"]
        if not raw.get("success"):
            warns.append("Сервис билетов вернул success=false")
        data = raw.get("data") or []
        offers: list[dict[str, Any]] = []
        for idx, item in enumerate(data[:10]):
            offers.append(
                {
                    "index": idx,
                    "price": item.get("price"),
                    "currency": item.get("currency") or raw.get("currency"),
                    "origin": item.get("origin"),
                    "destination": item.get("destination"),
                    "departureAt": item.get("departure_at"),
                    "airline": item.get("airline"),
                    "transfers": item.get("transfers"),
                    "duration": item.get("duration"),
                    "link": item.get("link"),
                }
            )
        return offers, warns

    async def _external_candidates(
        self,
        *,
        dest_lat: float,
        dest_lon: float,
        interests_payload: list[dict[str, Any]],
    ) -> tuple[list[dict[str, Any]], list[str]]:
        warns: list[str] = []
        if not interests_payload:
            return [], []
        external: list[dict[str, Any]] = []
        seen: set[tuple[str | None, str | None]] = set()
        # Берём интересы с наибольшим весом — по ним ищем POI в 2GIS
        for row in interests_payload[:6]:
            q = str(row["name"])
            iid = int(row["interestId"])
            try:
                items = await self.travel.dgis_search(
                    query=q,
                    lat=dest_lat,
                    lon=dest_lon,
                    radius_m=25_000,
                    limit=4,
                )
            except Exception as e:
                logger.warning("2gis search failed for {}: {}", q, e)
                warns.append(f"Поиск 2GIS по «{q}» недоступен")
                continue
            for it in items:
                key = (it.get("name"), it.get("address"))
                if key in seen:
                    continue
                seen.add(key)
                external.append(
                    {
                        "externalIndex": len(external),
                        "name": it.get("name"),
                        "address": it.get("address"),
                        "suggestedInterestId": iid,
                        "suggestedInterestName": q,
                    }
                )
                if len(external) >= 24:
                    return external, warns
        return external, warns

    def _build_context_json(
        self,
        *,
        origin_city: str,
        destination_city: str,
        dest_lat: float,
        dest_lon: float,
        day_count: int,
        start_date: str | None,
        end_date: str | None,
        user_interests: list[dict[str, Any]],
        flight_offers: list[dict[str, Any]],
        internal_posts: list[dict[str, Any]],
        external_candidates: list[dict[str, Any]],
    ) -> str:
        payload = {
            "originCity": origin_city,
            "destinationCity": destination_city,
            "destinationCenter": {"lat": dest_lat, "lon": dest_lon},
            "dayCount": day_count,
            "startDate": start_date,
            "endDate": end_date,
            "userInterests": user_interests,
            "flightOffers": flight_offers,
            "internalPosts": internal_posts,
            "externalCandidates": external_candidates,
        }
        return json.dumps(payload, ensure_ascii=False)

    def _stub_llm_out(
        self,
        *,
        destination_city: str,
        day_count: int,
        flight_offers: list[dict[str, Any]],
        internal_posts: list[dict[str, Any]],
        external_candidates: list[dict[str, Any]],
        user_interests: list[dict[str, Any]],
    ) -> TravelPlanLlmOut:
        top_interest_ids = [int(x["interestId"]) for x in user_interests[:3]]
        days: list[TravelPlanDayLlm] = []
        # День 1 — перелёт
        b1: list[TravelPlanBlockLlm] = []
        if flight_offers:
            wtxt = ""
            if user_interests:
                top = user_interests[0]
                wtxt = (
                    f" Учитываем ваш интерес «{top['name']}» (вес {top['weight']}) — "
                    f"в городе назначения подобраны точки под эти предпочтения."
                )
            b1.append(
                TravelPlanBlockLlm(
                    block_type="flight",
                    flight_offer_index=0,
                    rationale=(
                        f"Старт поездки: перелёт в пункт назначения.{wtxt} "
                        f"Ниже — вариант рейса из выдачи (индекс 0)."
                    ),
                    highlighted_interest_ids=top_interest_ids[:1],
                )
            )
        days.append(
            TravelPlanDayLlm(day_index=1, theme="Дорога", blocks=b1 or [TravelPlanBlockLlm(block_type="free_time", rationale="День в пути — добавьте перелёт вручную при отсутствии билетов.")])
        )

        pool: list[tuple[str, TravelPlanBlockLlm]] = []
        for p in internal_posts[:12]:
            pid = int(p["postId"])
            iids = [int(x) for x in p.get("interestIds") or []]
            matched = [i for i in iids if any(ui["interestId"] == i for ui in user_interests)]
            hi = matched[:3] if matched else top_interest_ids[:2]
            weight_hint = ""
            if user_interests and hi:
                ui = next((u for u in user_interests if u["interestId"] == hi[0]), None)
                if ui:
                    weight_hint = f"Знаем, что вам близок интерес «{ui['name']}» (вес {ui['weight']}) — "
            pool.append(
                (
                    "int",
                    TravelPlanBlockLlm(
                        block_type="internal_post",
                        post_id=pid,
                        rationale=f"{weight_hint}карточка из нашей базы: {p.get('title', 'место')}.",
                        highlighted_interest_ids=hi,
                    ),
                )
            )
        for ex in external_candidates[:10]:
            ei = int(ex["externalIndex"])
            sid = int(ex.get("suggestedInterestId") or 0)
            hi = [sid] if sid else top_interest_ids[:1]
            ui = next((u for u in user_interests if u["interestId"] == sid), None)
            wh = ""
            if ui:
                wh = f"Подходит под «{ui['name']}» (вес {ui['weight']}): "
            pool.append(
                (
                    "ext",
                    TravelPlanBlockLlm(
                        block_type="external_poi",
                        external_candidate_index=ei,
                        rationale=f"{wh}{ex.get('name') or 'точка 2GIS'}. {ex.get('address') or ''}".strip(),
                        highlighted_interest_ids=hi,
                    ),
                )
            )

        # Распределяем по дням 2..day_count
        di = 2
        while di <= max(day_count, 2) and pool:
            theme = f"День в {destination_city}" if di == 2 else f"Прогулки, день {di}"
            blocks: list[TravelPlanBlockLlm] = []
            for _ in range(3):
                if not pool:
                    break
                blocks.append(pool.pop(0)[1])
            if blocks:
                days.append(TravelPlanDayLlm(day_index=di, theme=theme, blocks=blocks))
            di += 1

        intro = (
            "Мы составили черновик маршрута без вызова нейросети (skipLlm). "
            "Добавьте интересы в профиль и карточки с координатами в городе назначения для богачего плана."
        )
        if user_interests:
            names = ", ".join(f"{u['name']} (вес {u['weight']})" for u in user_interests[:5])
            intro = f"Черновик плана с учётом ваших интересов: {names}. Режим без LLM (skipLlm)."

        return TravelPlanLlmOut(
            intro=intro,
            resolved_mode="global_then_local",
            days=days,
            warnings=[],
        )

    def _sanitize_llm(
        self,
        raw: TravelPlanLlmOut,
        *,
        max_post_id: set[int],
        n_external: int,
        n_flights: int,
    ) -> tuple[TravelPlanLlmOut, list[str]]:
        warns: list[str] = []
        new_days: list[TravelPlanDayLlm] = []
        for day in raw.days:
            blocks: list[TravelPlanBlockLlm] = []
            for b in day.blocks:
                if b.block_type == "internal_post":
                    if b.post_id is None or b.post_id not in max_post_id:
                        warns.append(f"Удалён блок с несуществующим post_id={b.post_id}")
                        continue
                elif b.block_type == "external_poi":
                    if b.external_candidate_index is None or not (
                        0 <= b.external_candidate_index < n_external
                    ):
                        warns.append(
                            f"Удалён внешний блок с индексом {b.external_candidate_index}"
                        )
                        continue
                elif b.block_type == "flight":
                    if not n_flights:
                        warns.append("Удалён блок перелёта — нет офферов")
                        continue
                    if b.flight_offer_index is None or not (
                        0 <= b.flight_offer_index < n_flights
                    ):
                        b = b.model_copy(
                            update={"flight_offer_index": 0},
                        )
                blocks.append(b)
            if blocks:
                new_days.append(
                    TravelPlanDayLlm(day_index=day.day_index, theme=day.theme, blocks=blocks)
                )
        return (
            TravelPlanLlmOut(
                intro=raw.intro,
                resolved_mode=raw.resolved_mode,
                days=new_days,
                warnings=list(raw.warnings) + warns,
            ),
            warns,
        )

    def _hydrate_days(
        self,
        days: list[TravelPlanDayLlm],
        *,
        posts_by_id: dict[int, tuple[Post, float | None]],
        external_catalog: list[dict[str, Any]],
        interest_names: dict[int, str],
    ) -> list[dict[str, Any]]:
        out: list[dict[str, Any]] = []
        ext_by_idx = {int(x["externalIndex"]): x for x in external_catalog}
        for d in days:
            blocks_out: list[dict[str, Any]] = []
            for b in d.blocks:
                hi = [
                    {"interestId": i, "name": interest_names.get(i, str(i))}
                    for i in b.highlighted_interest_ids
                ]
                common = {
                    "kind": b.block_type,
                    "rationale": b.rationale,
                    "highlightedInterests": hi,
                }
                if b.block_type == "internal_post" and b.post_id is not None:
                    row = posts_by_id.get(b.post_id)
                    if row:
                        post, avg = row
                        blocks_out.append(
                            {
                                **common,
                                "post": posts_api._to_response(post, avg).model_dump(
                                    by_alias=True
                                ),
                            }
                        )
                    continue
                if b.block_type == "external_poi" and b.external_candidate_index is not None:
                    ex = ext_by_idx.get(b.external_candidate_index)
                    if ex:
                        blocks_out.append({**common, "externalPoi": ex})
                    continue
                if b.block_type == "flight":
                    blocks_out.append(
                        {
                            **common,
                            "flightOfferIndex": b.flight_offer_index,
                        }
                    )
                    continue
                blocks_out.append(common)
            out.append(
                {
                    "dayIndex": d.day_index,
                    "theme": d.theme,
                    "blocks": blocks_out,
                }
            )
        return out

    async def build_plan(
        self,
        *,
        user: User,
        origin_city: str,
        destination_city: str,
        start_date: date | None = None,
        end_date: date | None = None,
        day_count: int | None = None,
        skip_llm: bool = False,
    ) -> TravelPlanBuildResult:
        warnings: list[str] = []
        o_center = resolve_city_center(origin_city)
        d_center = resolve_city_center(destination_city)
        if d_center is None:
            raise ValueError(f"Неизвестный город назначения: {destination_city!r} (добавьте в CITY_CENTERS)")
        if o_center is None:
            warnings.append(f"Координаты города отправления «{origin_city}» неизвестны — билеты всё равно ищем по названию")
        dest_lat, dest_lon = d_center

        dc = (end_date - start_date).days + 1 if start_date and end_date else None
        if day_count is not None and day_count > 0:
            dc_final = max(2, min(day_count, 14))
        elif dc is not None and dc > 0:
            dc_final = max(2, min(dc, 14))
        else:
            dc_final = 4

        start_s = start_date.isoformat() if start_date else None
        end_s = end_date.isoformat() if end_date else None

        flight_offers, w1 = await self._fetch_flights_safe(
            origin=origin_city.strip(),
            destination=destination_city.strip(),
            departure_at=start_s,
            return_at=None,
        )
        warnings.extend(w1)

        user_interests = await self._user_interests_payload(user)
        if not user_interests:
            warnings.append(
                "У пользователя нет привязанных интересов — добавьте их через соц. API для персонализации"
            )

        rows = await self._load_destination_posts(
            dest_city=destination_city, dest_lat=dest_lat, dest_lon=dest_lon, limit=45
        )
        post_ids = [p.id for p, _ in rows]
        scores = await self._interest_scores_for_posts(user.id, post_ids)
        internal_posts: list[dict[str, Any]] = []
        posts_by_id: dict[int, tuple[Post, float | None]] = {}
        for post, avg in rows:
            posts_by_id[post.id] = (post, avg)
            internal_posts.append(
                {
                    "postId": post.id,
                    "title": post.title,
                    "city": post.city,
                    "description": (post.description or "")[:400],
                    "lat": post.geo_lat,
                    "lon": post.geo_lng,
                    "interestIds": [i.id for i in post.interests],
                    "interestScore": scores.get(post.id, 0),
                }
            )
        internal_posts.sort(key=lambda x: (-x["interestScore"], -x["postId"]))

        external_candidates, w2 = await self._external_candidates(
            dest_lat=dest_lat,
            dest_lon=dest_lon,
            interests_payload=user_interests,
        )
        warnings.extend(w2)

        interest_names = {int(x["interestId"]): str(x["name"]) for x in user_interests}

        ctx = self._build_context_json(
            origin_city=origin_city,
            destination_city=destination_city,
            dest_lat=dest_lat,
            dest_lon=dest_lon,
            day_count=dc_final,
            start_date=start_s,
            end_date=end_s,
            user_interests=user_interests,
            flight_offers=flight_offers,
            internal_posts=internal_posts,
            external_candidates=external_candidates,
        )

        used_llm = False
        if skip_llm:
            llm_out = self._stub_llm_out(
                destination_city=destination_city,
                day_count=dc_final,
                flight_offers=flight_offers,
                internal_posts=internal_posts,
                external_candidates=external_candidates,
                user_interests=user_interests,
            )
        else:
            if not settings.GPT_CLIENT_KEY or not settings.GPT_CLIENT_BASE_URL:
                raise ValueError(
                    "LLM не настроен (GPT_CLIENT_KEY / GPT_CLIENT_BASE_URL). "
                    "Передайте skipLlm=true для теста без нейросети."
                )
            gpt = GptService()
            try:
                llm_out, _tok = await gpt.request_openai_pydantic_response(
                    sys_prompt=TRAVEL_PLAN_SYSTEM_PROMPT,
                    user_prompt=(
                        "Сконструируй план поездки по следующему JSON-контексту:\n" + ctx
                    ),
                    response_model=TravelPlanLlmOut,
                    max_tokens=4096,
                    temperature=0.35,
                )
                used_llm = True
            finally:
                await gpt.close()

        llm_out, w3 = self._sanitize_llm(
            llm_out,
            max_post_id=set(posts_by_id.keys()),
            n_external=len(external_candidates),
            n_flights=len(flight_offers),
        )
        warnings.extend(w3)

        hydrated = self._hydrate_days(
            llm_out.days,
            posts_by_id=posts_by_id,
            external_catalog=external_candidates,
            interest_names=interest_names,
        )

        return TravelPlanBuildResult(
            intro=llm_out.intro,
            resolved_mode=llm_out.resolved_mode,
            warnings=warnings + list(llm_out.warnings),
            flight_offers=flight_offers,
            external_catalog=external_candidates,
            days=hydrated,
            used_llm=used_llm,
        )
