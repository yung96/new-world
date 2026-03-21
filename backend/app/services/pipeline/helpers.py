from __future__ import annotations

import math
from datetime import date
from typing import Any

from app.models.post import Post


def haversine(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    R = 6371
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) ** 2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon / 2) ** 2
    return 2 * R * math.atan2(math.sqrt(a), math.sqrt(1 - a))


def season_from_dates(d_from: str | date | None, d_to: str | date | None) -> str:
    if isinstance(d_from, str):
        d_from = date.fromisoformat(d_from)
    d = d_from or date.today()
    m = d.month
    if m in (3, 4, 5): return "spring"
    if m in (6, 7, 8): return "summer"
    if m in (9, 10, 11): return "autumn"
    return "winter"


def parse_date(val: str | date | None) -> date | None:
    if val is None: return None
    if isinstance(val, date): return val
    return date.fromisoformat(val)


def nearest_n(lat: float, lng: float, posts: list[Post], n: int, max_km: float = 10) -> list[tuple[Post, float]]:
    scored = []
    for p in posts:
        if not p.geo_lat or not p.geo_lng:
            continue
        d = haversine(lat, lng, p.geo_lat, p.geo_lng)
        if d <= max_km:
            scored.append((p, d))
    scored.sort(key=lambda x: x[1])
    return scored[:n]


INTEREST_QUERIES: dict[str, list[str]] = {
    "gastro": ["ресторан", "кафе", "столовая"],
    "wine": ["винодельня", "винный бар", "дегустация"],
    "eco": ["экотропа", "заповедник", "нацпарк"],
    "nature": ["водопад", "смотровая площадка", "парк"],
    "culture": ["музей", "театр", "галерея"],
    "relax": ["спа", "термальный источник", "пляж"],
    "active": ["прокат велосипедов", "рафтинг", "скалодром"],
    "workation": ["коворкинг", "кофейня с wifi"],
}

PACE_POINTS = {"relaxed": 3, "balanced": 5, "intensive": 8}
