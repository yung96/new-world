from __future__ import annotations

import json
from dataclasses import dataclass
from typing import Any

from loguru import logger
from sqlalchemy import func, select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.core.config import settings
from app.models.interest import Interest
from app.models.post import Post
from app.models.review import Review
from app.models.user import User
from app.schemas.ivan_alt_local_route_llm import (
    IvanAltLocalRouteLlmOut,
    IvanAltLocalRouteStopLlm,
)
from app.services.ivan_alt_gpt_service import IvanAltGptService
from app.services.user_route_service import UserRouteService

LOCAL_ROUTE_SYSTEM_PROMPT = """Ты составляешь пеший/локальный маршрут по местам из базы приложения «Краевед».

Правила:
1) В ordered_stops должны быть РОВНО все post_id из массива candidatePlaces (поле postId у каждого элемента), каждый id — ровно один раз. Никаких других чисел: только целые postId из этого списка. Порядок остановок выбираешь сам: удобная цепочка по карте (lat/lon), пешая логика, смысл маршрута. НЕ упорядочивай места по relevanceScore и по весам из userInterests — веса не задают порядок.
2) Точка старта пользователя (startLat/startLng) — не пост; её не включай в post_id. Работай только с id из candidatePlaces.
3) В caption для каждой остановки: обращение на «вы», тёплый тон; можно мягко связать с интересами пользователя из userInterests (названия интересов). Не ссылайся на числовые веса и не объясняй порядок через «главнее / менее важно».
4) В тексте caption используй только то, что можно вывести из полей этого места в candidatePlaces: title, description, city, interestIds и названия интересов из userInterests. Не придумывай конкретные детали (меню, экспозиции, цены, часы, «десерты», «аттракционы» и т.п.), если их нет в title/description. Допустимы общие формулировки без новых фактов.
5) highlighted_interest_ids — 0–5 id из userInterests, релевантных этой остановке (пересечение с interestIds места).
6) Ответ строго по схеме (structured output). Язык: русский."""


@dataclass
class IvanAltLocalRouteBuildResult:
    route_title: str
    intro: str | None
    candidate_ids: list[int]
    stops: list[dict[str, Any]]
    warnings: list[str]
    used_llm: bool
    trace: dict[str, Any] | None = None


class IvanAltLocalRouteService:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def _assert_interest_ids_exist(self, interest_ids: list[int]) -> None:
        if not interest_ids:
            return
        stmt = select(func.count(Interest.id)).where(Interest.id.in_(interest_ids))
        n = int((await self.db.execute(stmt)).scalar_one() or 0)
        if n != len(set(interest_ids)):
            raise ValueError("Один или несколько interestId не найдены в справочнике")

    async def _load_posts_in_bbox(
        self,
        *,
        lat: float,
        lng: float,
        delta_deg: float,
        pool_limit: int = 400,
    ) -> list[Post]:
        lat_min, lat_max = lat - delta_deg, lat + delta_deg
        lon_min, lon_max = lng - delta_deg, lng + delta_deg
        stmt = (
            select(Post)
            .where(
                Post.geo_lat.isnot(None),
                Post.geo_lng.isnot(None),
                Post.geo_lat.between(lat_min, lat_max),
                Post.geo_lng.between(lon_min, lon_max),
            )
            .options(selectinload(Post.interests))
            .order_by(Post.id.asc())
            .limit(pool_limit)
        )
        return list((await self.db.execute(stmt)).scalars().all())

    def _score_post(self, post: Post, weight_by_interest: dict[int, int]) -> int:
        total = 0
        for intr in post.interests:
            w = weight_by_interest.get(intr.id)
            if w is not None:
                total += w
        return total

    async def _interest_names(self, interest_ids: list[int]) -> dict[int, str]:
        if not interest_ids:
            return {}
        stmt = select(Interest).where(Interest.id.in_(interest_ids))
        rows = (await self.db.execute(stmt)).scalars().all()
        return {i.id: i.name for i in rows}

    def _stub_llm(
        self,
        *,
        candidate_ids: list[int],
        names_by_interest: dict[int, str],
    ) -> IvanAltLocalRouteLlmOut:
        hint = ""
        if names_by_interest:
            top = list(names_by_interest.values())[:3]
            hint = f" Учтены ваши интересы: {', '.join(top)}."
        return IvanAltLocalRouteLlmOut(
            route_title="Локальный маршрут (черновик без LLM)",
            intro=f"Подобраны места рядом с точкой старта.{hint}",
            ordered_stops=[
                IvanAltLocalRouteStopLlm(
                    post_id=pid,
                    caption=(
                        f"Место #{pid}: хороший вариант в цепочке — смотрится в тему ваших интересов."
                    ),
                    highlighted_interest_ids=[],
                )
                for pid in candidate_ids
            ],
        )

    _FALLBACK_CAPTION = (
        "Точка в маршруте — загляните по пути; смотрится в тему ваших интересов."
    )

    @staticmethod
    def _repair_llm_order(
        raw: IvanAltLocalRouteLlmOut,
        candidate_ids_ordered: list[int],
    ) -> tuple[IvanAltLocalRouteLlmOut, list[str]]:
        """
        Приводит ответ LLM к множеству кандидатов: отбрасывает чужие id и дубликаты,
        недостающие места дописывает в конец (порядок кандидатов по релевантности).
        """
        warns: list[str] = []
        expected_set = set(candidate_ids_ordered)
        if not candidate_ids_ordered:
            return raw, warns

        invalid: list[int] = []
        ordered: list[IvanAltLocalRouteStopLlm] = []
        used: set[int] = set()

        for s in raw.ordered_stops:
            pid = s.post_id
            if pid not in expected_set:
                invalid.append(pid)
                continue
            if pid in used:
                continue
            ordered.append(s)
            used.add(pid)

        if invalid:
            tail = "" if len(invalid) <= 15 else " …"
            warns.append(
                "LLM вернул post_id вне списка кандидатов (отброшены): "
                + ", ".join(str(x) for x in invalid[:15])
                + tail
            )

        raw_n = len(raw.ordered_stops)
        if len(used) < len(expected_set):
            n_miss = len(expected_set) - len(used)
            warns.append(
                f"В ответе LLM не хватало {n_miss} из {len(expected_set)} кандидатов — "
                "добавлены в конец цепочки с нейтральной подписью."
            )
        elif raw_n > len(ordered) and not invalid:
            warns.append(
                "В ordered_stops были дубликаты — сохранён первый валидный порядок по каждому post_id."
            )

        missing = [pid for pid in candidate_ids_ordered if pid not in used]
        for pid in missing:
            ordered.append(
                IvanAltLocalRouteStopLlm(
                    post_id=pid,
                    caption=IvanAltLocalRouteService._FALLBACK_CAPTION,
                    highlighted_interest_ids=[],
                )
            )
            used.add(pid)

        repaired = IvanAltLocalRouteLlmOut(
            route_title=raw.route_title,
            intro=raw.intro,
            ordered_stops=ordered,
        )
        return repaired, warns

    async def build(
        self,
        *,
        user: User | None,
        start_lat: float,
        start_lng: float,
        start_label: str | None,
        n: int,
        interest_weights: list[tuple[int, int]],
        bbox_delta_degrees: float,
        skip_llm: bool = False,
        include_trace: bool = False,
    ) -> IvanAltLocalRouteBuildResult:
        warnings: list[str] = []
        if not interest_weights:
            raise ValueError("Передайте хотя бы одну пару (interestId, weight)")

        weight_by_iid: dict[int, int] = {}
        for iid, w in interest_weights:
            if w < 1:
                raise ValueError("Вес интереса должен быть >= 1")
            weight_by_iid[iid] = w

        await self._assert_interest_ids_exist(list(weight_by_iid.keys()))

        posts = await self._load_posts_in_bbox(
            lat=start_lat,
            lng=start_lng,
            delta_deg=bbox_delta_degrees,
        )
        if not posts:
            raise ValueError(
                "В выбранной области нет мест с координатами — увеличьте bboxDeltaDegrees или сместите точку А"
            )

        scored: list[tuple[Post, int]] = [
            (p, self._score_post(p, weight_by_iid)) for p in posts
        ]
        scored.sort(key=lambda x: (-x[1], -x[0].id))
        top = scored[:n]
        candidate_posts = [t[0] for t in top]
        candidate_ids = [p.id for p in candidate_posts]

        if len(candidate_ids) < n:
            warnings.append(
                f"В области найдено только {len(candidate_ids)} мест с координатами (запрошено {n})"
            )

        names = await self._interest_names(list(weight_by_iid.keys()))
        user_interests_payload = [
            {"interestId": iid, "name": names.get(iid, str(iid)), "weight": w}
            for iid, w in sorted(weight_by_iid.items(), key=lambda x: -x[1])
        ]

        candidates_payload = []
        for p in candidate_posts:
            sc = self._score_post(p, weight_by_iid)
            candidates_payload.append(
                {
                    "postId": p.id,
                    "title": p.title,
                    "city": p.city,
                    "description": (p.description or "")[:400],
                    "lat": p.geo_lat,
                    "lon": p.geo_lng,
                    "interestIds": [i.id for i in p.interests],
                    "relevanceScore": sc,
                }
            )

        ctx = {
            "startLat": start_lat,
            "startLng": start_lng,
            "startLabel": start_label,
            "userInterests": user_interests_payload,
            "candidatePlaces": candidates_payload,
        }
        ctx_json = json.dumps(ctx, ensure_ascii=False)
        id_list_str = ", ".join(str(x) for x in candidate_ids)
        user_prompt = (
            "Собери маршрут по JSON-контексту:\n"
            + ctx_json
            + f"\n\nНапоминание: в ordered_stops допустимы ТОЛЬКО эти post_id (ровно все, по одному разу): [{id_list_str}]."
        )
        trace: dict[str, Any] | None = None
        if include_trace:
            trace = {
                "systemPrompt": LOCAL_ROUTE_SYSTEM_PROMPT,
                "userPrompt": user_prompt,
                "context": json.loads(ctx_json),
            }

        used_llm = False
        if skip_llm:
            llm_out = self._stub_llm(
                candidate_ids=candidate_ids,
                names_by_interest=names,
            )
        else:
            if not settings.GPT_CLIENT_KEY or not settings.GPT_CLIENT_BASE_URL:
                raise ValueError(
                    "LLM не настроен (GPT_CLIENT_KEY / GPT_CLIENT_BASE_URL). "
                    "Передайте skipLlm=true для черновика без нейросети."
                )
            gpt = IvanAltGptService()
            try:
                llm_out, _tok = await gpt.request_openai_pydantic_response(
                    sys_prompt=LOCAL_ROUTE_SYSTEM_PROMPT,
                    user_prompt=user_prompt,
                    response_model=IvanAltLocalRouteLlmOut,
                    max_tokens=4096,
                    temperature=0.35,
                )
                if llm_out is None:
                    raise ValueError("LLM вернул пустой разбор ответа")
                used_llm = True
            finally:
                await gpt.close()

        llm_out, w2 = self._repair_llm_order(llm_out, candidate_ids)
        warnings.extend(w2)

        stops_out: list[dict[str, Any]] = []
        for s in llm_out.ordered_stops:
            stops_out.append(
                {
                    "postId": s.post_id,
                    "caption": s.caption,
                    "highlightedInterestIds": list(s.highlighted_interest_ids),
                }
            )

        return IvanAltLocalRouteBuildResult(
            route_title=llm_out.route_title,
            intro=llm_out.intro,
            candidate_ids=candidate_ids,
            stops=stops_out,
            warnings=warnings,
            used_llm=used_llm,
            trace=trace,
        )

    async def build_and_maybe_save(
        self,
        *,
        user: User,
        start_lat: float,
        start_lng: float,
        start_label: str | None,
        n: int,
        interest_weights: list[tuple[int, int]],
        bbox_delta_degrees: float,
        save: bool,
        skip_llm: bool,
        include_trace: bool = False,
    ) -> tuple[IvanAltLocalRouteBuildResult, int | None]:
        result = await self.build(
            user=user,
            start_lat=start_lat,
            start_lng=start_lng,
            start_label=start_label,
            n=n,
            interest_weights=interest_weights,
            bbox_delta_degrees=bbox_delta_degrees,
            skip_llm=skip_llm,
            include_trace=include_trace,
        )
        route_id: int | None = None
        if save:
            post_ids = [s["postId"] for s in result.stops]
            meta: dict[str, Any] = {
                "intro": result.intro,
                "stops": result.stops,
                "usedLlm": result.used_llm,
                "candidateIds": result.candidate_ids,
            }
            route_svc = UserRouteService(self.db)
            route = await route_svc.create_ai_route(
                user=user,
                title=result.route_title,
                start_lat=start_lat,
                start_lng=start_lng,
                start_label=start_label,
                post_ids=post_ids,
                ai_route_meta=meta,
            )
            route_id = route.id
            logger.info("Saved AI local route id=%s user=%s", route_id, user.id)
        return result, route_id
