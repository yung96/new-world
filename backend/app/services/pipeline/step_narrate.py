from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.core.config import settings
from app.db import async_session_factory
from app.models.route import Route, RouteSegment, SegmentItem
from app.services.gpt_service import GptService


async def step_narrate(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        route = await db.get(Route, route_id)
        if not route:
            return

        items = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(RouteSegment.route_id == route_id, SegmentItem.type == "experience", SegmentItem.parent_id.isnot(None))
            .order_by(RouteSegment.position, SegmentItem.position)
        )).scalars().all()

        recs = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(RouteSegment.route_id == route_id, SegmentItem.parent_id.isnot(None))
        )).scalars().all()

        if not items:
            route.status = "ready"
            await db.commit()
            return

        # Build LLM context
        p = route.params or {}
        stops_ctx = []
        for item in items:
            d = json.loads(item.details or "{}")
            stops_ctx.append({
                "name": d.get("name", ""),
                "description": (d.get("description") or "")[:200],
                "lat": d.get("lat"),
                "lng": d.get("lng"),
                "distance_to_next_km": d.get("distance_to_next_km"),
                "duration_to_next_min": d.get("duration_to_next_min"),
            })

        recs_ctx = []
        for rec in recs:
            d = json.loads(rec.details or "{}")
            if d.get("recommendation_type"):
                recs_ctx.append({"type": d["recommendation_type"], "options": d.get("options", [])})

        llm_context = {
            "filters": {
                "groupType": p.get("groupType", "solo"),
                "transport": p.get("transport", "car"),
                "budget": p.get("budget", "mid"),
                "interests": p.get("interests", []),
                "pace": p.get("pace", "balanced"),
                "dateFrom": p.get("dateFrom"),
                "dateTo": p.get("dateTo"),
            },
            "weather": p.get("weather", {}),
            "weatherPerDay": p.get("weatherPerDay", []),
            "events": p.get("events", []),
            "offers": p.get("offers", []),
            "stops": stops_ctx,
            "recommendations": recs_ctx,
            "totalKm": p.get("total_km", 0),
        }

        # Build stub narrative as fallback
        weather = p.get("weather", {})
        group = p.get("groupType", "solo")
        events = p.get("events", [])
        offers = p.get("offers", [])

        lines = [f"Маршрут для {group}, {len(stops_ctx)} точек, {p.get('total_km', '?')} км."]

        if weather.get("temperature"):
            lines.append(f"Погода: {weather.get('weather', '')}, {weather.get('temperature')}°C.")

        lines.append("")
        for i, s in enumerate(stops_ctx):
            line = f"{i+1}. {s['name']}"
            if s.get("description"):
                line += f" — {s['description'][:80]}"
            if s.get("distance_to_next_km"):
                line += f" (→ {s['distance_to_next_km']} км, ~{s['duration_to_next_min']} мин)"
            lines.append(line)

        if events:
            lines.append("\nСобытия на ваши даты:")
            for e in events:
                lines.append(f"  • {e['title']} ({e['dateFrom']} — {e['dateTo']})")

        if offers:
            lines.append("\nАктуальные акции:")
            for o in offers:
                lines.append(f"  • {o['title']}: {o['description']}")

        stub_narrative = "\n".join(lines)

        # GPT call: use real LLM if key is configured, otherwise fall back to stub
        gpt_key = settings.GPT_CLIENT_KEY
        narrative = stub_narrative

        if gpt_key and gpt_key.lower() not in ("fake", "x", ""):
            try:
                sys_prompt = (
                    "Ты составляешь описание туристического маршрута по Краснодарскому краю. "
                    "Отвечай только текстом маршрута, без вводных фраз."
                )
                user_prompt = (
                    "Ты составляешь описание туристического маршрута по Краснодарскому краю.\n\n"
                    f"Контекст маршрута (JSON):\n{json.dumps(llm_context, ensure_ascii=False, indent=2)}\n\n"
                    "Напиши от второго лица (\"вы\") тёплый текст 3-5 абзацев:\n"
                    "- Введение про маршрут (куда, на сколько дней, для кого)\n"
                    "- По каждой остановке: что там делать, что попробовать, на что обратить внимание\n"
                    "- Если есть события на даты — упомяни\n"
                    "- Если есть акции — упомяни\n"
                    "- Конкретные детали: расстояния, время в пути, погода\n"
                    "- Без слов \"уникальный\", \"незабываемый\", \"удивительный\""
                )

                gpt = GptService()
                try:
                    completion = await gpt.request_openai_text_response(
                        sys_prompt=sys_prompt,
                        user_prompt=user_prompt,
                        max_tokens=1500,
                    )
                    gpt_text = completion.choices[0].message.content
                    if gpt_text and gpt_text.strip():
                        narrative = gpt_text.strip()
                        logger.info("[pipeline] narrate: GPT narrative generated for route {}", route_id)
                    else:
                        logger.warning("[pipeline] narrate: GPT returned empty content, using stub")
                finally:
                    await gpt.close()

            except Exception as exc:
                logger.warning(
                    "[pipeline] narrate: GPT call failed for route {}, using stub. Error: {}",
                    route_id,
                    exc,
                )

        route.narrative = narrative

        # Save context for future LLM
        pp = dict(route.params) if route.params else {}
        pp["llm_context"] = llm_context
        route.params = pp

        route.status = "ready"
        await db.commit()
        logger.info("[pipeline] narrate: route {} READY", route_id)
