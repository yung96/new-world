#!/usr/bin/env python3
"""
Тщательная проверка ленты /api/user/feed на проде (или API_BASE_URL).

  API_BASE_URL=https://apikraeved.tw1.su/api python3 backend/scripts/smoke_feed_interests.py

Проверки:
  1) Лента без JWT — 401
  2) С JWT — 200, есть total/page/items
  3) Один интерес в профиле: пост с этим тегом выше поста с другим тегом
  4) Два интереса + избранное по «якорю» с интересом A: вес A растёт, пост только с A
     должен быть раньше поста только с B (сумма весов в персональном скоре)
  5) Два запроса подряд page=1 — одинаковый порядок id (детерминизм)
  6) total в ленте совпадает с GET /posts
"""

from __future__ import annotations

import json
import os
import ssl
import sys
import time
import urllib.error
import urllib.request

BASE = (os.environ.get("API_BASE_URL") or "https://apikraeved.tw1.su/api").rstrip("/")
CTX = ssl.create_default_context()


def req(
    method: str,
    url: str,
    *,
    data=None,
    token=None,
    timeout: int = 90,
):
    h = {"Accept": "application/json"}
    if data is not None:
        h["Content-Type"] = "application/json"
    if token:
        h["Authorization"] = f"Bearer {token}"
    body = json.dumps(data).encode() if data is not None else None
    r = urllib.request.Request(url, data=body, headers=h, method=method)
    try:
        with urllib.request.urlopen(r, timeout=timeout, context=CTX) as resp:
            raw = resp.read().decode()
            code = resp.status
            return code, json.loads(raw) if raw else None
    except urllib.error.HTTPError as e:
        raw = e.read().decode() if e.fp else ""
        try:
            parsed = json.loads(raw) if raw else None
        except json.JSONDecodeError:
            parsed = raw
        return e.code, parsed


def fail(msg: str) -> None:
    print(f"FAIL: {msg}", file=sys.stderr)


def ok(msg: str) -> None:
    print(f"OK  {msg}")


def main() -> int:
    print(f"API: {BASE}\n")
    failed = 0

    # --- 1) Без авторизации
    code, _ = req("GET", f"{BASE}/user/feed?page=1&pageSize=5")
    if code == 401:
        ok("лента без токена → 401")
    elif code == 403:
        ok("лента без токена → 403 (допустимо для OAuth2)")
    else:
        fail(f"ожидался 401/403 без токена, получено {code}")
        failed += 1

    phone = os.environ.get("SEED_USER_PHONE") or f"+7999feed{int(time.time())}"
    code, auth = req("POST", f"{BASE}/auth", data={"phone": phone})
    if code != 200 or not isinstance(auth, dict):
        fail(f"auth: {code} {auth}")
        return 1
    token = auth["access_token"]
    print(f"Пользователь: {phone}\n")

    # --- 2) Структура ответа + total vs /posts
    code, feed = req("GET", f"{BASE}/user/feed?page=1&pageSize=5", token=token)
    if code != 200 or not isinstance(feed, dict):
        fail(f"feed: {code} {feed}")
        return 1
    for key in ("items", "total", "page", "pageSize"):
        if key not in feed:
            fail(f"нет поля {key} в ответе ленты")
            failed += 1
            break
    else:
        ok("лента с JWT: 200 и поля items/total/page/pageSize")

    code, pub = req("GET", f"{BASE}/posts?page=1&pageSize=1")
    if code == 200 and isinstance(pub, dict) and feed.get("total") == pub.get("total"):
        ok("total ленты совпадает с GET /posts")
    else:
        fail(f"total ленты {feed.get('total')} != posts {pub if isinstance(pub, dict) else pub}")
        failed += 1

    # --- Интересы
    code, interests_page = req("GET", f"{BASE}/interests?page=1&pageSize=100")
    if code != 200 or not interests_page.get("items"):
        fail(f"список интересов: {code}")
        return 1
    items = interests_page["items"]
    if len(items) < 3:
        fail("нужно ≥3 интереса в справочнике")
        return 1
    id_a, id_b = items[0]["id"], items[1]["id"]

    # --- 3) Один интерес A: пост A выше поста B
    code, _ = req(
        "POST",
        f"{BASE}/interests/bulk_create",
        token=token,
        data=[id_a],
    )
    if code != 200:
        fail(f"bulk_create [A]: {code}")
        failed += 1

    ts = int(time.time())
    c_b, post_b = req(
        "POST",
        f"{BASE}/user/posts",
        token=token,
        data={
            "title": f"chk3-B-{ts}",
            "mediaUrls": [],
            "interestIds": [id_b],
            "season": "summer",
            "geoLat": 55.75,
            "geoLng": 37.61,
        },
    )
    c_a, post_a = req(
        "POST",
        f"{BASE}/user/posts",
        token=token,
        data={
            "title": f"chk3-A-{ts}",
            "mediaUrls": [],
            "interestIds": [id_a],
            "season": "summer",
            "geoLat": 55.76,
            "geoLng": 37.62,
        },
    )
    if c_a != 201 or c_b != 201 or not isinstance(post_a, dict) or not isinstance(post_b, dict):
        fail(f"создание постов chk3: A={c_a} B={c_b}")
        failed += 1
    else:
        pid_a, pid_b = post_a["id"], post_b["id"]
        code, feed = req("GET", f"{BASE}/user/feed?page=1&pageSize=15", token=token)
        ids = [x["id"] for x in feed.get("items", [])]
        if pid_a not in ids:
            fail(f"пост A не в первых 15: {pid_a} ids={ids}")
            failed += 1
        else:
            pa, pb = ids.index(pid_a), ids.index(pid_b) if pid_b in ids else 999
            if pa < pb:
                ok(f"проверка 3: пост с интересом A (pos {pa}) выше поста B (pos {pb})")
            else:
                fail(f"проверка 3: ожидалось pos A < pos B, получено A={pa} B={pb}")
                failed += 1

    # --- 4) Два интереса A+B, избранное на якоре только с A → вес A выше; новые посты A vs B
    code, _ = req(
        "POST",
        f"{BASE}/interests/bulk_create",
        token=token,
        data=[id_b],
    )
    if code != 200:
        fail(f"bulk_add B: {code}")
        failed += 1

    code, anchor = req(
        "POST",
        f"{BASE}/user/posts",
        token=token,
        data={
            "title": f"anchor-A-{ts}",
            "mediaUrls": [],
            "interestIds": [id_a],
            "season": "autumn",
            "geoLat": 55.0,
            "geoLng": 37.0,
        },
    )
    if code != 201:
        fail(f"якорь: {code} {anchor}")
        failed += 1
    else:
        aid = anchor["id"]
        code, _ = req("POST", f"{BASE}/user/favorites/{aid}", token=token)
        if code != 204:
            fail(f"избранное якоря: {code}")
            failed += 1

    c_h, ph = req(
        "POST",
        f"{BASE}/user/posts",
        token=token,
        data={
            "title": f"wA-{ts}",
            "mediaUrls": [],
            "interestIds": [id_a],
            "season": "winter",
            "geoLat": 56.0,
            "geoLng": 38.0,
        },
    )
    c_l, pl = req(
        "POST",
        f"{BASE}/user/posts",
        token=token,
        data={
            "title": f"wB-{ts}",
            "mediaUrls": [],
            "interestIds": [id_b],
            "season": "winter",
            "geoLat": 56.1,
            "geoLng": 38.1,
        },
    )
    if c_h != 201 or c_l != 201 or not isinstance(ph, dict) or not isinstance(pl, dict):
        fail(f"посты wA/wB: {c_h} {c_l}")
        failed += 1
    else:
        hid, lid = ph["id"], pl["id"]
        code, feed = req("GET", f"{BASE}/user/feed?page=1&pageSize=25", token=token)
        ids = [x["id"] for x in feed.get("items", [])]
        if hid not in ids or lid not in ids:
            fail(f"проверка 4: новые посты не в первых 25 hid={hid} lid={lid}")
            failed += 1
        else:
            ha, lb = ids.index(hid), ids.index(lid)
            if ha < lb:
                ok(
                    f"проверка 4: после избранного по A пост с A (pos {ha}) выше поста с B (pos {lb}) — учёт весов"
                )
            else:
                fail(f"проверка 4: ожидалось wA выше wB, ha={ha} lb={lb}")
                failed += 1

    # --- 5) Детерминизм первой страницы
    code, f1 = req("GET", f"{BASE}/user/feed?page=1&pageSize=20", token=token)
    code, f2 = req("GET", f"{BASE}/user/feed?page=1&pageSize=20", token=token)
    if code == 200 and isinstance(f1, dict) and isinstance(f2, dict):
        i1 = [x["id"] for x in f1.get("items", [])]
        i2 = [x["id"] for x in f2.get("items", [])]
        if i1 == i2:
            ok("проверка 5: два GET /user/feed?page=1 — одинаковый порядок id")
        else:
            fail(f"проверка 5: порядок различается\n  {i1[:8]}\n  {i2[:8]}")
            failed += 1
    else:
        fail(f"проверка 5: {code}")
        failed += 1

    print()
    if failed:
        print(f"Итого: {failed} замечаний (см. FAIL выше).")
        return 1
    print("Итого: все проверки пройдены.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
