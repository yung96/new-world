#!/usr/bin/env python3
"""
Заполняет API демо-данными: N уникальных интересов и N карточек (постов).
У каждой карточки несколько интересов (по умолчанию от 2 до 4 штук).

Использование (из корня репозитория):
  export API_BASE_URL=https://apikraeved.tw1.su/api
  export SEED_USER_PHONE=+79991234567   # опционально, иначе генерируется
  export SEED_INTERESTS_PER_CARD_MIN=2 SEED_INTERESTS_PER_CARD_MAX=4  # опционально
  python3 scripts/seed_demo_cards_and_interests.py

Либо из каталога backend:
  python3 scripts/seed_demo_cards_and_interests.py

Уже созданные карточки с одним интересом можно догрузить до нескольких:
  python3 scripts/update_existing_posts_multi_interests.py

Требуется доступ к сети. JWT скрипт получает сам: POST /api/auth с телефоном
(`SEED_USER_PHONE` или автогенерация). Интересы — POST /api/admin/interests,
карточки — POST /api/posts с заголовком Authorization: Bearer <JWT>.
"""

from __future__ import annotations

import os
import random
import sys
import time

_SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
if _SCRIPT_DIR not in sys.path:
    sys.path.insert(0, _SCRIPT_DIR)

from seed_api_common import (
    INTERESTS_PER_CARD_MAX,
    INTERESTS_PER_CARD_MIN,
    fetch_jwt,
    interest_ids_for_post,
    req,
)

N = 50

# Разнообразные подписи к интересам и местам (кратко, для демо)
INTEREST_LABELS = [
    "Пешие прогулки",
    "Велосипед",
    "Каякинг",
    "Лыжи",
    "Скалолазание",
    "Йога в парке",
    "Фотография природы",
    "Пикники",
    "Исторические экскурсии",
    "Музеи",
    "Гастрономия",
    "Кофейни",
    "Винодельни",
    "Фермерские рынки",
    "Архитектура модерна",
    "Православные храмы",
    "Крепости",
    "Парки и сады",
    "Зоопарк",
    "Ботанический сад",
    "Ночная астрономия",
    "Пляжный отдых",
    "Сапбординг",
    "Рыбалка",
    "Конные прогулки",
    "Треккинг",
    "Горные тропы",
    "Озёра",
    "Водопады",
    "Пещеры",
    "Термальные источники",
    "Баня и спа",
    "Мастер-классы",
    "Ремесла",
    "Керамика",
    "Книжные магазины",
    "Джаз-клубы",
    "Театр",
    "Кино под открытым небом",
    "Стрит-арт",
    "Антикварные лавки",
    "Смотровые площадки",
    "Мосты",
    "Набережные",
    "Острова",
    "Маяки",
    "Маяк и закат",
    "Усадьбы",
    "Деревянное зодчество",
    "Индустриальный туризм",
]

EMOJIS = [
    "🥾",
    "🚴",
    "🛶",
    "⛷️",
    "🧗",
    "🧘",
    "📷",
    "🧺",
    "🏛️",
    "🖼️",
    "🍽️",
    "☕",
    "🍷",
    "🌾",
    "🏢",
    "⛪",
    "🏰",
    "🌳",
    "🦁",
    "🌺",
    "🌌",
    "🏖️",
    "🏄",
    "🎣",
    "🐎",
    "🥾",
    "⛰️",
    "🏞️",
    "💧",
    "🦇",
    "♨️",
    "🧖",
    "🎨",
    "🪚",
    "🏺",
    "📚",
    "🎷",
    "🎭",
    "🎬",
    "🎨",
    "🏺",
    "🔭",
    "🌉",
    "🌊",
    "🏝️",
    "🗼",
    "🌅",
    "🏡",
    "🪵",
    "🏭",
]

SEASONS = ["spring", "summer", "autumn", "winter"]


def main() -> int:
    lo, hi = INTERESTS_PER_CARD_MIN, INTERESTS_PER_CARD_MAX
    if lo < 1 or hi < 1 or lo > hi:
        print(
            f"Некорректно: SEED_INTERESTS_PER_CARD_MIN/MAX → {lo}..{hi}",
            file=sys.stderr,
        )
        return 1

    base = (os.environ.get("API_BASE_URL") or "https://apikraeved.tw1.su/api").rstrip(
        "/"
    )
    phone = os.environ.get("SEED_USER_PHONE") or f"+7999seed{int(time.time())}"
    run_id = int(time.time())

    print(f"API: {base}")
    print(f"Пользователь для постов: {phone}")

    try:
        jwt_token = fetch_jwt(base, phone)
    except RuntimeError as e:
        print(e, file=sys.stderr)
        return 1
    tail = jwt_token[-12:] if len(jwt_token) > 12 else jwt_token
    print(f"JWT получен (…{tail})")

    print(
        f"Создаём по {N} интересов и карточек "
        f"(на карточку {INTERESTS_PER_CARD_MIN}–{INTERESTS_PER_CARD_MAX} интересов)…"
    )

    interest_ids: list[int] = []
    for i in range(N):
        label = INTEREST_LABELS[i % len(INTEREST_LABELS)]
        name = f"{label} · сид #{run_id}-{i + 1:02d}"
        emoji = EMOJIS[i % len(EMOJIS)]
        code, payload = req(
            "POST",
            f"{base}/admin/interests",
            data={"name": name, "emoji": emoji},
        )
        # FastAPI по умолчанию отдаёт 200 на POST, если не задан status_code=201
        if code not in (200, 201) or not isinstance(payload, dict) or "id" not in payload:
            print(f"Ошибка интереса {i + 1}: HTTP {code} {payload}", file=sys.stderr)
            return 1
        interest_ids.append(int(payload["id"]))
        print(f"  интерес {i + 1}/{N} id={payload['id']} {name[:50]}…")

    post_ids: list[int] = []
    for i in range(N):
        card_interest_ids = interest_ids_for_post(interest_ids, i, n_total=N)
        title = f"Демо-место «{INTEREST_LABELS[i % len(INTEREST_LABELS)]}» #{run_id}-{i + 1}"
        desc = (
            f"Автоматически созданная карточка для демонстрации. "
            f"Интересы (id): {', '.join(str(x) for x in card_interest_ids)}. Пакет сидирования."
        )
        season = SEASONS[i % len(SEASONS)]
        code, payload = req(
            "POST",
            f"{base}/posts",
            token=jwt_token,
            data={
                "title": title,
                "description": desc,
                "mediaUrls": [],
                "interestIds": card_interest_ids,
                "season": season,
                "geoLat": round(55.75 + random.uniform(-0.2, 0.2), 5),
                "geoLng": round(37.62 + random.uniform(-0.2, 0.2), 5),
            },
        )
        if code not in (200, 201) or not isinstance(payload, dict) or "id" not in payload:
            print(f"Ошибка поста {i + 1}: HTTP {code} {payload}", file=sys.stderr)
            return 1
        post_ids.append(int(payload["id"]))
        print(
            f"  пост {i + 1}/{N} id={payload['id']} season={season} "
            f"интересов={len(card_interest_ids)}"
        )

    print("—" * 40)
    print(f"Готово: {len(interest_ids)} интересов, {len(post_ids)} постов.")
    print(f"Первый interest_id={interest_ids[0]}, последний={interest_ids[-1]}")
    print(f"Первый post_id={post_ids[0]}, последний={post_ids[-1]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
