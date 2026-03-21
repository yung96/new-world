#!/usr/bin/env python3
"""
Обновляет уже существующие карточки (посты): проставляет по несколько интересов,
по той же схеме, что и seed_demo_cards_and_interests.py (скользящее окно).

По умолчанию трогает только посты с заголовком, начинающимся с «Демо-место»
(как у скрипта сидирования). Остальные можно включить переменной окружения.

  API_BASE_URL=https://apikraeved.tw1.su/api python3 backend/scripts/update_existing_posts_multi_interests.py

Переменные:
  UPDATE_POSTS_ALL=1          — обновить все посты (осторожно)
  UPDATE_POSTS_TITLE_PREFIX=  — пусто: только UPDATE_POSTS_ALL=1 имеет смысл
  UPDATE_POSTS_TITLE_PREFIX=Демо-место — префикс заголовка (по умолчанию)
  SEED_INTERESTS_PER_CARD_MIN / SEED_INTERESTS_PER_CARD_MAX — как в seed-скрипте
"""

from __future__ import annotations

import os
import sys

_SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
if _SCRIPT_DIR not in sys.path:
    sys.path.insert(0, _SCRIPT_DIR)

from seed_api_common import (
    INTERESTS_PER_CARD_MAX,
    INTERESTS_PER_CARD_MIN,
    fetch_all_interest_ids,
    fetch_all_posts,
    interest_ids_for_post,
    req,
)


def main() -> int:
    lo, hi = INTERESTS_PER_CARD_MIN, INTERESTS_PER_CARD_MAX
    if lo < 1 or hi < 1 or lo > hi:
        print(f"Некорректно: SEED_INTERESTS_PER_CARD_MIN/MAX → {lo}..{hi}", file=sys.stderr)
        return 1

    base = (os.environ.get("API_BASE_URL") or "https://apikraeved.tw1.su/api").rstrip("/")
    update_all = os.environ.get("UPDATE_POSTS_ALL", "").strip() in ("1", "true", "yes")
    prefix = os.environ.get("UPDATE_POSTS_TITLE_PREFIX", "Демо-место")

    print(f"API: {base}")
    print(f"Интересов на карточку: {lo}–{hi}")

    try:
        pool = fetch_all_interest_ids(base)
    except RuntimeError as e:
        print(e, file=sys.stderr)
        return 1

    if len(pool) < 2:
        print("В API меньше двух интересов — нечем заполнить карточки.", file=sys.stderr)
        return 1
    print(f"Всего интересов в справочнике: {len(pool)} (id {pool[0]} … {pool[-1]})")

    posts = fetch_all_posts(base)
    if not posts:
        print("Постов не найдено.")
        return 0

    if update_all:
        selected = posts
        print(f"Режим: все посты ({len(selected)} шт.)")
    else:
        selected = [p for p in posts if str(p.get("title", "")).startswith(prefix)]
        print(f"Режим: заголовок начинается с «{prefix}» → {len(selected)} из {len(posts)}")

    if not selected:
        print("Нет подходящих постов. Задайте UPDATE_POSTS_ALL=1 или другой префикс.")
        return 0

    ordered = sorted(selected, key=lambda p: int(p["id"]))
    ok = 0
    for idx, post in enumerate(ordered):
        pid = int(post["id"])
        new_ids = interest_ids_for_post(pool, idx, n_total=len(pool))
        code, payload = req(
            "PATCH",
            f"{base}/posts/{pid}",
            data={"interestIds": new_ids},
        )
        if code not in (200, 201) or not isinstance(payload, dict):
            print(f"Ошибка PATCH поста {pid}: HTTP {code} {payload}", file=sys.stderr)
            return 1
        got = payload.get("interestIds") or []
        print(f"  пост id={pid} ← {len(got)} интересов {got}")
        ok += 1

    print("—" * 40)
    print(f"Обновлено постов: {ok}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
