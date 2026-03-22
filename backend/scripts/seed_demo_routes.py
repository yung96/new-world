#!/usr/bin/env python3
"""
Seed script: 3 demo routes with segments and experience items.

Usage (from backend/ directory):
    python scripts/seed_demo_routes.py

Idempotent: checks share_token before inserting. Safe to re-run.
"""

from __future__ import annotations

import json
import os
import sys
from datetime import date

# ---------------------------------------------------------------------------
# Path + env setup — must happen before any app import
# ---------------------------------------------------------------------------
_BACKEND_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if _BACKEND_DIR not in sys.path:
    sys.path.insert(0, _BACKEND_DIR)

os.environ.setdefault(
    "DATABASE_URL",
    "postgresql+asyncpg://kraeved_user:kraeved_password@localhost:15432/kraeved",
)
os.environ.setdefault("SECRET_KEY", "x")
os.environ.setdefault("TRAVEL_API_KEY", "x")
os.environ.setdefault("TGIS_API_KEY", "x")
os.environ.setdefault("DADATA_API_KEY", "x")

from sqlalchemy import create_engine, select, text
from sqlalchemy.orm import Session

from app.models.route import Route, RouteSegment, SegmentItem
from app.models.user import User

# ---------------------------------------------------------------------------
# DB engine (sync psycopg2 for seeding)
# ---------------------------------------------------------------------------
SYNC_DB_URL = "postgresql+psycopg2://kraeved_user:kraeved_password@localhost:15432/kraeved"
engine = create_engine(SYNC_DB_URL, pool_pre_ping=True)


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def get_first_user(session: Session) -> User:
    user = session.query(User).order_by(User.id).first()
    if not user:
        raise RuntimeError("No users found in DB. Run user seed first.")
    return user


def get_post_coords(session: Session, post_id: int) -> tuple[float | None, float | None]:
    row = session.execute(
        text("SELECT geo_lat, geo_lng FROM posts WHERE id = :id"),
        {"id": post_id},
    ).fetchone()
    if row:
        return row[0], row[1]
    return None, None


def get_post_info(session: Session, post_id: int) -> dict:
    row = session.execute(
        text("SELECT title, description, geo_lat, geo_lng FROM posts WHERE id = :id"),
        {"id": post_id},
    ).fetchone()
    if row:
        return {
            "title": row[0] or "",
            "description": row[1] or "",
            "lat": row[2],
            "lng": row[3],
        }
    return {"title": "", "description": "", "lat": None, "lng": None}


def route_exists(session: Session, share_token: str) -> bool:
    return session.query(Route).filter_by(share_token=share_token).first() is not None


def create_route_with_segments(
    session: Session,
    author_id: int,
    title: str,
    narrative: str,
    total_days: int,
    share_token: str,
    params: dict,
    days: list[dict],  # [{"title": "День 1", "date_from": date, "date_to": date, "post_ids": [...]}, ...]
) -> Route:
    """
    Create a Route with RouteSegments (one per day) and SegmentItems.

    Each day gets:
      - one SegmentItem type="day" (the day container)
      - N SegmentItem type="experience", parent_id=day_item.id
    """
    total_experiences = sum(len(d["post_ids"]) for d in days)

    route = Route(
        author_id=author_id,
        title=title,
        narrative=narrative,
        total_days=total_days,
        status="ready",
        share_token=share_token,
        params=params,
        total_experiences=total_experiences,
    )
    session.add(route)
    session.flush()  # get route.id

    for day_index, day_def in enumerate(days):
        segment = RouteSegment(
            route_id=route.id,
            position=day_index,
            title=day_def["title"],
            date_from=day_def.get("date_from"),
            date_to=day_def.get("date_to"),
        )
        session.add(segment)
        session.flush()  # get segment.id

        # Day container item
        day_item = SegmentItem(
            segment_id=segment.id,
            parent_id=None,
            type="day",
            position=0,
            details=json.dumps({"label": day_def["title"]}),
        )
        session.add(day_item)
        session.flush()  # get day_item.id

        # Experience items
        for exp_index, post_id in enumerate(day_def["post_ids"]):
            info = get_post_info(session, post_id)
            details = {
                "name": info["title"],
                "lat": info["lat"],
                "lng": info["lng"],
                "post_id": post_id,
                "description": info["description"],
            }
            exp_item = SegmentItem(
                segment_id=segment.id,
                parent_id=day_item.id,
                type="experience",
                position=exp_index + 1,
                details=json.dumps(details),
            )
            session.add(exp_item)

    session.flush()
    return route


# ---------------------------------------------------------------------------
# Route definitions
# ---------------------------------------------------------------------------

ROUTES = [
    {
        "title": "Винный weekend для двоих",
        "share_token": "demo-wine-weekend",
        "total_days": 2,
        "params": {
            "groupType": "couple",
            "transport": "car",
            "budget": "mid",
            "interests": ["wine", "gastro"],
            "pace": "relaxed",
        },
        "narrative": (
            "Этот маршрут создан для тех, кто хочет провести выходные в окружении виноградников, "
            "тихих горных дорог и вкусной еды. Вы начнёте с Абрау-Дюрсо — одного из старейших "
            "винодельческих хозяйств России, где можно продегустировать игристые вина прямо у "
            "берега озера. Затем вас ждёт Лефкадия с её бутиковыми сортами и живописными терруарами, "
            "а вечер завершится на ферме Экзархо, где готовят блюда из собственного хозяйства.\n\n"
            "На второй день маршрут становится спокойнее: прогулка у Кипарисового озера с его "
            "особенной атмосферой южной природы, а финалом станет Старый парк в Кабардинке — "
            "место с вековыми деревьями и скульптурами, где хорошо просто сидеть и разговаривать. "
            "Примерный путь на машине — около 120 км за два дня, без спешки."
        ),
        "days": [
            {
                "title": "День 1",
                "date_from": date(2025, 5, 10),
                "date_to": date(2025, 5, 10),
                "post_ids": [524, 528, 532],
            },
            {
                "title": "День 2",
                "date_from": date(2025, 5, 11),
                "date_to": date(2025, 5, 11),
                "post_ids": [530, 533],
            },
        ],
    },
    {
        "title": "Семейный день в Сочи",
        "share_token": "demo-family-sochi",
        "total_days": 1,
        "params": {
            "groupType": "family",
            "transport": "car",
            "budget": "mid",
            "interests": ["nature", "family", "adventure"],
            "pace": "balanced",
        },
        "narrative": (
            "Один насыщенный день, который понравится и взрослым, и детям. Начните с SkyPark — "
            "самого длинного пешеходного подвесного моста в мире, откуда открывается вид на "
            "реку Мзымта и горные склоны. Дети будут в восторге, а взрослые успеют сделать "
            "фотографии, которые не стыдно показать. Потом — 33 водопада в Хосте: короткий "
            "маршрут по ущелью с каскадами и прохладой, где можно перекусить и отдохнуть.\n\n"
            "Завершить день стоит на Роза Хутор: летом здесь работают подъёмники в горы, "
            "пешеходные тропы и набережная с ресторанами. Суммарный путь на машине — около "
            "60 км, большая часть по живописной дороге вдоль гор. Выезжайте пораньше: "
            "у водопадов и SkyPark в выходные бывают очереди."
        ),
        "days": [
            {
                "title": "День 1",
                "date_from": date(2025, 6, 15),
                "date_to": date(2025, 6, 15),
                "post_ids": [525, 527, 529],
            },
        ],
    },
    {
        "title": "Горный трекинг",
        "share_token": "demo-mountain-trek",
        "total_days": 2,
        "params": {
            "groupType": "friends",
            "transport": "none",
            "budget": "low",
            "interests": ["hiking", "nature", "mountains"],
            "pace": "active",
        },
        "narrative": (
            "Маршрут для тех, кто приехал не загорать, а ходить. В первый день — Гуамское "
            "ущелье: узкий каньон с отвесными скалами и узкоколейкой, один из самых "
            "впечатляющих пеших маршрутов края. Здесь можно провести несколько часов, "
            "двигаясь вдоль реки Курджипс. Потом — 33 водопада, чтобы закрыть первый день "
            "купанием и отдыхом у воды. Ночёвка в Хосте или Лазаревском.\n\n"
            "На второй день — Роза Хутор, но не как курорт, а как база для выхода в горы. "
            "Летом тропы открыты до высоты 2200 м, виды на Главный Кавказский хребет "
            "компенсируют усталость в ногах. Суммарный набор высоты за два дня — около "
            "1500 м. Берите треккинговые палки и запас воды."
        ),
        "days": [
            {
                "title": "День 1",
                "date_from": date(2025, 7, 20),
                "date_to": date(2025, 7, 20),
                "post_ids": [531, 527],
            },
            {
                "title": "День 2",
                "date_from": date(2025, 7, 21),
                "date_to": date(2025, 7, 21),
                "post_ids": [529],
            },
        ],
    },
]


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    print("=" * 60)
    print("  Seed: demo routes")
    print("=" * 60)

    with Session(engine) as session:
        author = get_first_user(session)
        print(f"  Using author: id={author.id}, phone={author.phone}")

        for route_def in ROUTES:
            token = route_def["share_token"]

            if route_exists(session, token):
                print(f"  [SKIP] Route '{route_def['title']}' already exists (share_token={token})")
                continue

            route = create_route_with_segments(
                session=session,
                author_id=author.id,
                title=route_def["title"],
                narrative=route_def["narrative"],
                total_days=route_def["total_days"],
                share_token=token,
                params=route_def["params"],
                days=route_def["days"],
            )
            session.commit()

            print(
                f"  [OK] Route '{route.title}' created: "
                f"id={route.id}, days={route.total_days}, "
                f"experiences={route.total_experiences}, token={token}"
            )

    print("\nDone.")


if __name__ == "__main__":
    main()
