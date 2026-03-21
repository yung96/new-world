"""Общие HTTP-хелперы и логика «несколько интересов на карточку» для скриптов сидирования."""

from __future__ import annotations

import json
import os
import random
import ssl
import urllib.error
import urllib.request
from typing import Any

INTERESTS_PER_CARD_MIN = int(os.environ.get("SEED_INTERESTS_PER_CARD_MIN", "2"))
INTERESTS_PER_CARD_MAX = int(os.environ.get("SEED_INTERESTS_PER_CARD_MAX", "4"))


def interest_ids_for_post(pool: list[int], post_index: int, *, n_total: int) -> list[int]:
    """Несколько разных интересов: скользящее окно по списку + случайный размер."""
    k = random.randint(INTERESTS_PER_CARD_MIN, INTERESTS_PER_CARD_MAX)
    k = min(k, n_total)
    idxs = [(post_index + j) % n_total for j in range(k)]
    return [pool[i] for i in idxs]


def req(
    method: str,
    url: str,
    *,
    data: dict[str, Any] | None = None,
    token: str | None = None,
    timeout: int = 120,
) -> tuple[int, Any]:
    headers = {"Accept": "application/json"}
    if data is not None:
        headers["Content-Type"] = "application/json"
    if token:
        headers["Authorization"] = f"Bearer {token}"
    body = json.dumps(data).encode() if data is not None else None
    r = urllib.request.Request(url, data=body, headers=headers, method=method)
    ctx = ssl.create_default_context()
    try:
        with urllib.request.urlopen(r, timeout=timeout, context=ctx) as resp:
            raw = resp.read().decode()
            code = resp.status
            if not raw:
                return code, None
            return code, json.loads(raw)
    except urllib.error.HTTPError as e:
        err_body = e.read().decode() if e.fp else ""
        try:
            parsed = json.loads(err_body) if err_body else None
        except json.JSONDecodeError:
            parsed = err_body
        raise RuntimeError(f"HTTP {e.code} {method} {url}: {parsed}") from e


def fetch_jwt(base: str, phone: str) -> str:
    code, payload = req("POST", f"{base}/auth", data={"phone": phone})
    if code != 200 or not isinstance(payload, dict):
        raise RuntimeError(f"auth: ожидался 200 и JSON, получено {code}: {payload}")
    token = payload.get("access_token")
    if not token or not isinstance(token, str):
        raise RuntimeError(f"auth: в ответе нет access_token: {payload}")
    return token


def fetch_all_interest_ids(base: str) -> list[int]:
    """Все id интересов, по возрастанию."""
    out: list[dict[str, Any]] = []
    page = 1
    total = None
    while True:
        code, data = req("GET", f"{base}/interests?page={page}&pageSize=100")
        if code != 200 or not isinstance(data, dict):
            raise RuntimeError(f"interests page {page}: HTTP {code} {data}")
        items = data.get("items") or []
        if not items:
            break
        out.extend(items)
        total = data.get("total")
        if total is not None and len(out) >= total:
            break
        page += 1
        if page > 500:
            break
    ids = sorted({int(x["id"]) for x in out})
    return ids


def fetch_all_posts(base: str) -> list[dict[str, Any]]:
    """Все посты (пагинация)."""
    out: list[dict[str, Any]] = []
    page = 1
    while True:
        code, data = req("GET", f"{base}/posts?page={page}&pageSize=100")
        if code != 200 or not isinstance(data, dict):
            raise RuntimeError(f"posts page {page}: HTTP {code} {data}")
        items = data.get("items") or []
        if not items:
            break
        out.extend(items)
        total = data.get("total")
        if total is not None and len(out) >= total:
            break
        page += 1
        if page > 500:
            break
    return out
