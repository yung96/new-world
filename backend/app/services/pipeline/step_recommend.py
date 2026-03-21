from __future__ import annotations

import json
from typing import Any

from loguru import logger
from sqlalchemy import select

from app.db import async_session_factory
from app.models.post import Post
from app.models.route import RouteSegment, SegmentItem
from app.services.pipeline.helpers import nearest_n


async def step_recommend(route_id: int, params: dict[str, Any]) -> None:
    async with async_session_factory() as db:
        items = (await db.execute(
            select(SegmentItem).join(RouteSegment)
            .where(RouteSegment.route_id == route_id, SegmentItem.type == "experience", SegmentItem.parent_id.is_(None))
            .order_by(SegmentItem.position)
        )).scalars().all()

        if not items:
            return

        seg_id = items[0].segment_id

        food_posts = (await db.execute(
            select(Post).where(Post.description.in_(["Ресторан", "Кафе"]), Post.geo_lat.isnot(None))
        )).scalars().all()

        stay_posts = (await db.execute(
            select(Post).where(Post.description.in_(["Гостиница", "Кемпинг / Глэмпинг"]), Post.geo_lat.isnot(None))
        )).scalars().all()

        rec_pos = 1000

        # 2-3 food options near each stop
        for item in items:
            d = json.loads(item.details or "{}")
            lat, lng = d.get("lat", 0), d.get("lng", 0)
            if not lat or not lng:
                continue

            nearest_food = nearest_n(lat, lng, food_posts, 3)
            food_options = [
                {"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                 "lat": fp.geo_lat, "lng": fp.geo_lng, "type": fp.description}
                for fp, dist in nearest_food
            ]

            if food_options:
                db.add(SegmentItem(
                    segment_id=seg_id, parent_id=item.id, type="experience", position=rec_pos,
                    details=json.dumps({"recommendation_type": "food", "options": food_options}),
                ))
                rec_pos += 1

        # 2-3 stay options for the route
        first_d = json.loads(items[0].details or "{}")
        nearest_stays = nearest_n(first_d.get("lat", 0), first_d.get("lng", 0), stay_posts, 3, max_km=50)
        stay_options = [
            {"name": sp.title, "post_id": sp.id, "distance_km": round(dist, 1),
             "lat": sp.geo_lat, "lng": sp.geo_lng, "type": sp.description}
            for sp, dist in nearest_stays
        ]

        if stay_options:
            db.add(SegmentItem(
                segment_id=seg_id, parent_id=None, type="stay", position=rec_pos,
                details=json.dumps({"recommendation_type": "stay", "options": stay_options}),
            ))
            rec_pos += 1

        # Fuel if car
        if params.get("transport") == "car":
            fuel_posts = (await db.execute(
                select(Post).where(Post.description == "Автозаправочная станция", Post.geo_lat.isnot(None))
            )).scalars().all()

            mid_item = items[len(items) // 2]
            mid_d = json.loads(mid_item.details or "{}")
            nearest_fuel = nearest_n(mid_d.get("lat", 0), mid_d.get("lng", 0), fuel_posts, 2)
            fuel_options = [
                {"name": fp.title, "post_id": fp.id, "distance_km": round(dist, 1),
                 "lat": fp.geo_lat, "lng": fp.geo_lng}
                for fp, dist in nearest_fuel
            ]

            if fuel_options:
                db.add(SegmentItem(
                    segment_id=seg_id, parent_id=mid_item.id, type="experience", position=rec_pos,
                    details=json.dumps({"recommendation_type": "fuel", "options": fuel_options}),
                ))

        await db.commit()
        logger.info("[pipeline] recommend: route {}", route_id)
