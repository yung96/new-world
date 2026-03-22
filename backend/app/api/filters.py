from __future__ import annotations

from datetime import date, datetime

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, ConfigDict, Field
from sqlalchemy import select, func, delete
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.core.dependencies import get_db_session
from app.models.associations import FilterPreset
from app.models.geo import GeoRegion
from app.models.user import User

router = APIRouter(prefix="/filters")


# ── Static filter config (no auth, for building UI) ──────────────────────────

class FilterOptionOut(BaseModel):
    value: str
    label: str

class FilterConfigOut(BaseModel):
    groupTypes: list[FilterOptionOut]
    transportTypes: list[FilterOptionOut]
    budgetLevels: list[FilterOptionOut]
    paceOptions: list[FilterOptionOut]
    interests: list[FilterOptionOut]
    seasons: list[FilterOptionOut]
    pinTypes: list[FilterOptionOut]
    placeTypes: list[FilterOptionOut]


FILTER_CONFIG = FilterConfigOut(
    groupTypes=[
        FilterOptionOut(value="solo", label="Один"),
        FilterOptionOut(value="couple", label="Пара"),
        FilterOptionOut(value="family", label="Семья"),
        FilterOptionOut(value="friends", label="Друзья"),
        FilterOptionOut(value="elderly", label="Пожилые"),
        FilterOptionOut(value="workation", label="Workation"),
    ],
    transportTypes=[
        FilterOptionOut(value="car", label="Авто"),
        FilterOptionOut(value="public", label="Общественный транспорт"),
        FilterOptionOut(value="none", label="Без машины"),
    ],
    budgetLevels=[
        FilterOptionOut(value="low", label="Низкий"),
        FilterOptionOut(value="mid", label="Средний"),
        FilterOptionOut(value="high", label="Высокий"),
    ],
    paceOptions=[
        FilterOptionOut(value="relaxed", label="Спокойный"),
        FilterOptionOut(value="balanced", label="Сбалансированный"),
        FilterOptionOut(value="intensive", label="Насыщенный"),
    ],
    interests=[
        FilterOptionOut(value="gastro", label="Гастро"),
        FilterOptionOut(value="wine", label="Вино"),
        FilterOptionOut(value="eco", label="Эко"),
        FilterOptionOut(value="nature", label="Природа"),
        FilterOptionOut(value="culture", label="Культура"),
        FilterOptionOut(value="relax", label="Отдых"),
        FilterOptionOut(value="active", label="Активность"),
        FilterOptionOut(value="workation", label="Workation"),
    ],
    seasons=[
        FilterOptionOut(value="spring", label="Весна"),
        FilterOptionOut(value="summer", label="Лето"),
        FilterOptionOut(value="autumn", label="Осень"),
        FilterOptionOut(value="winter", label="Зима"),
    ],
    pinTypes=[
        FilterOptionOut(value="city", label="Город"),
        FilterOptionOut(value="stay", label="Отель / ночлег"),
        FilterOptionOut(value="experience", label="Достопримечательность"),
        FilterOptionOut(value="transport_hub", label="Вокзал / аэропорт"),
        FilterOptionOut(value="photo_spot", label="Фототочка"),
        FilterOptionOut(value="food", label="Кафе / ресторан"),
        FilterOptionOut(value="custom", label="Своя метка"),
    ],
    placeTypes=[
        FilterOptionOut(value="attraction", label="Достопримечательность"),
        FilterOptionOut(value="restaurant", label="Ресторан"),
        FilterOptionOut(value="cafe", label="Кафе"),
        FilterOptionOut(value="hotel", label="Гостиница"),
        FilterOptionOut(value="winery", label="Винодельня"),
        FilterOptionOut(value="beach", label="Пляж"),
        FilterOptionOut(value="waterfall", label="Водопад"),
        FilterOptionOut(value="viewpoint", label="Смотровая площадка"),
        FilterOptionOut(value="museum", label="Музей"),
        FilterOptionOut(value="camping", label="Кемпинг"),
        FilterOptionOut(value="farm", label="Ферма"),
        FilterOptionOut(value="park", label="Парк"),
        FilterOptionOut(value="excursion", label="Экскурсия"),
        FilterOptionOut(value="event", label="Мероприятие"),
        FilterOptionOut(value="fuel", label="Заправка"),
    ],
)


@router.get(
    "/config",
    response_model=FilterConfigOut,
    status_code=status.HTTP_200_OK,
    summary="Конфиг фильтров для UI",
)
async def get_filter_config():
    return FILTER_CONFIG


CITY_INFO: dict[str, dict] = {
    "Краснодар": {"desc": "Столица края. Парк Галицкого, улица Красная, стадион. Жарко летом.", "avgPrice": 3500},
    "Сочи": {"desc": "Море и горы. Олимпийский парк, Роза Хутор, дендрарий.", "avgPrice": 5000},
    "Новороссийск": {"desc": "Порт, Абрау-Дюрсо рядом. Ветер норд-ост, набережная, мемориал.", "avgPrice": 3000},
    "Анапа": {"desc": "Песчаные пляжи, Кипарисовое озеро, семейный курорт.", "avgPrice": 3500},
    "Геленджик": {"desc": "Бухта, канатка на Сафари-парк, скала Парус.", "avgPrice": 4000},
    "Горячий Ключ": {"desc": "Термальные источники, Дантово ущелье, тишина.", "avgPrice": 2500},
    "Красная Поляна": {"desc": "Горы 2320м, лыжи зимой, трекинг летом.", "avgPrice": 6000},
    "Туапсе": {"desc": "Скала Киселёва, лесистые горы, немноголюдно.", "avgPrice": 2500},
    "Ейск": {"desc": "Азовское море, мелко и тепло. Коса, виндсёрфинг.", "avgPrice": 2000},
    "Тамань": {"desc": "Вино, грязевые вулканы, коса Тузла. Лермонтов был.", "avgPrice": 2000},
    "Армавир": {"desc": "Купеческий город, парк, тихо. Транзит на юг.", "avgPrice": 2000},
    "Кабардинка": {"desc": "Старый парк, набережная, тише Геленджика.", "avgPrice": 3500},
    "Архипо-Осиповка": {"desc": "Долина у моря, водопады рядом, дольмены.", "avgPrice": 3000},
    "Апшеронск": {"desc": "Гуамское ущелье, узкоколейка, горный воздух.", "avgPrice": 2000},
    "Псебай": {"desc": "Ворота в горы. Рафтинг, скалы, мало туристов.", "avgPrice": 1500},
}


@router.get(
    "/cities",
    summary="Города с фото, описанием и ценами",
)
async def get_cities_with_photos(
    db: AsyncSession = Depends(get_db_session),
):
    from sqlalchemy import func as sa_func
    from app.models.post import Post

    result = await db.execute(
        select(GeoRegion)
        .where(GeoRegion.type == "city")
        .order_by(GeoRegion.name)
    )
    cities = result.scalars().all()

    # Count places per city
    counts = {}
    count_result = await db.execute(
        select(Post.region_id, sa_func.count(Post.id))
        .where(Post.region_id.isnot(None))
        .group_by(Post.region_id)
    )
    for region_id, cnt in count_result.all():
        counts[region_id] = cnt

    out = []
    for c in cities:
        info = CITY_INFO.get(c.name, {})
        out.append({
            "id": c.id,
            "name": c.name,
            "slug": c.slug,
            "photo": c.photo_url,
            "centroid": c.centroid,
            "population": c.population,
            "description": info.get("desc"),
            "avgPricePerDay": info.get("avgPrice"),
            "placesCount": counts.get(c.id, 0),
        })
    return out


@router.get(
    "/regions",
    summary="Регионы/районы/города для карты",
)
async def get_regions(
    type: str | None = None,
    parent_id: int | None = None,
    db: AsyncSession = Depends(get_db_session),
):
    """
    Без параметров — всё. type=city/district/region. parent_id — дочерние.
    Фронт использует для зума: zoom < 8 → district, zoom >= 8 → city.
    """
    stmt = select(GeoRegion)
    if type:
        stmt = stmt.where(GeoRegion.type == type)
    if parent_id:
        stmt = stmt.where(GeoRegion.parent_id == parent_id)
    stmt = stmt.order_by(GeoRegion.name)

    result = await db.execute(stmt)
    regions = result.scalars().all()
    return [
        {
            "id": r.id,
            "name": r.name,
            "slug": r.slug,
            "type": r.type,
            "parentId": r.parent_id,
            "photo": r.photo_url,
            "centroid": r.centroid,
            "population": r.population,
        }
        for r in regions
    ]


@router.get(
    "/map-points",
    summary="Все слои карты: районы (полигоны) + города + места",
)
async def get_map_points(
    zoom: int = 6,
    lat: float | None = None,
    lng: float | None = None,
    db: AsyncSession = Depends(get_db_session),
):
    """
    Всегда отдаёт все слои. Фронт сам решает что показывать по зуму.
    zoom передаётся для оптимизации: при мелком зуме места фильтруются шире.
    """
    import json as _json
    from sqlalchemy.orm import selectinload
    from sqlalchemy import func as sa_func
    from app.models.post import Post

    # Counts per region
    counts = {}
    cnt_res = await db.execute(
        select(Post.region_id, sa_func.count(Post.id)).where(Post.region_id.isnot(None)).group_by(Post.region_id)
    )
    for rid, cnt in cnt_res.all():
        counts[rid] = cnt

    # Districts with polygons
    districts_res = await db.execute(select(GeoRegion).where(GeoRegion.type == "district"))
    districts = [
        {
            "id": r.id,
            "name": r.name,
            "slug": r.slug,
            "type": "district",
            "centroid": r.centroid,
            "photo": r.photo_url,
            "polygon": _json.loads(r.polygon) if r.polygon else None,
            "population": r.population,
            "placesCount": counts.get(r.id, 0),
            "description": CITY_INFO.get(r.name, {}).get("desc"),
        }
        for r in districts_res.scalars().all() if r.centroid
    ]

    # Cities
    cities_res = await db.execute(select(GeoRegion).where(GeoRegion.type == "city"))
    cities = [
        {
            "id": c.id,
            "name": c.name,
            "slug": c.slug,
            "type": "city",
            "centroid": c.centroid,
            "photo": c.photo_url,
            "population": c.population,
            "placesCount": counts.get(c.id, 0),
            "description": CITY_INFO.get(c.name, {}).get("desc"),
            "avgPricePerDay": CITY_INFO.get(c.name, {}).get("avgPrice"),
        }
        for c in cities_res.scalars().all() if c.centroid
    ]

    # Places
    stmt = (
        select(Post)
        .where(Post.geo_lat.isnot(None))
        .options(selectinload(Post.media), selectinload(Post.interests))
    )
    if lat and lng:
        delta = 2.0 if zoom < 8 else 1.0 if zoom < 12 else 0.5
        stmt = stmt.where(
            Post.geo_lat.between(lat - delta, lat + delta),
            Post.geo_lng.between(lng - delta, lng + delta),
        )
    stmt = stmt.limit(200)
    posts_res = await db.execute(stmt)
    places = [
        {
            "id": p.id,
            "name": p.title,
            "type": "place",
            "lat": p.geo_lat,
            "lng": p.geo_lng,
            "description": p.description,
            "photos": [m.url for m in p.media] if p.media else [],
            "city": p.city,
            "regionId": p.region_id,
            "season": p.season.value if hasattr(p.season, "value") else str(p.season),
            "needCar": p.need_car,
            "priceLevel": p.price_level.value if p.price_level and hasattr(p.price_level, "value") else None,
            "ratingAvg": float(p.rating_avg) if p.rating_avg else None,
            "reviewsCount": p.reviews_count,
            "address": p.address,
            "phone": p.phone,
            "website": p.website,
            "interests": [{"id": i.id, "name": i.name, "emoji": i.emoji} for i in p.interests] if p.interests else [],
            "verified": p.verified,
        }
        for p in posts_res.scalars().all()
    ]

    return {
        "zoom": zoom,
        "districts": districts,
        "cities": cities,
        "places": places,
    }


# ── User presets CRUD ────────────────────────────────────────────────────────

class PresetCreateRequest(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    dateFrom: date | None = None
    dateTo: date | None = None
    groupType: str | None = None
    groupSize: int | None = Field(default=None, ge=1, le=20)
    transport: str | None = None
    budget: str | None = None
    interests: list[str] | None = None
    pace: str | None = None


class PresetOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    dateFrom: date | None = Field(None, alias="date_from")
    dateTo: date | None = Field(None, alias="date_to")
    groupType: str | None = Field(None, alias="group_type")
    groupSize: int | None = Field(None, alias="group_size")
    transport: str | None
    budget: str | None
    interests: list[str] | None
    pace: str | None
    createdAt: datetime = Field(alias="created_at")


@router.get(
    "/presets",
    response_model=list[PresetOut],
    summary="Мои пресеты фильтров",
)
async def list_presets(
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    stmt = (
        select(FilterPreset)
        .where(FilterPreset.user_id == user.id)
        .order_by(FilterPreset.created_at.desc())
    )
    result = await db.execute(stmt)
    return result.scalars().all()


@router.post(
    "/presets",
    response_model=PresetOut,
    status_code=status.HTTP_201_CREATED,
    summary="Сохранить пресет",
)
async def create_preset(
    body: PresetCreateRequest,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    preset = FilterPreset(
        user_id=user.id,
        name=body.name,
        date_from=body.dateFrom,
        date_to=body.dateTo,
        group_type=body.groupType,
        group_size=body.groupSize,
        transport=body.transport,
        budget=body.budget,
        interests=body.interests,
        pace=body.pace,
    )
    db.add(preset)
    await db.commit()
    await db.refresh(preset)
    return preset


@router.delete(
    "/presets/{preset_id}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Удалить пресет",
)
async def delete_preset(
    preset_id: int,
    user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    preset = await db.get(FilterPreset, preset_id)
    if not preset or preset.user_id != user.id:
        raise HTTPException(status_code=404, detail="Preset not found")
    await db.delete(preset)
    await db.commit()
