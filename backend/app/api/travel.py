import math
from datetime import date, datetime, timezone
from typing import Literal, Optional

from fastapi import APIRouter, Depends, HTTPException, Query, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import Field
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.auth import get_current_user
from app.api.base_schema import BasePydanticModel
from app.core.dependencies import get_db_session
from app.models.user import User
from app.services.travel_plan_service import TravelPlanService
from app.services.travel_service import TravelService


# --- Схемы (DTOs) ---
class CheapFlightsRequestDTO(BasePydanticModel):
    currency: str = Field(default="rub")

    origin: str = Field(
        description="Наименование города отправления",
        examples=["Москва"],
    )
    destination: str = Field(
        description="Наименование города назначения",
        examples=["Краснодар"],
    )

    departure_at: Optional[str] = Field(
        default=None,
        description="YYYY-MM or YYYY-MM-DD",
    )
    return_at: Optional[str] = None

    one_way: bool = True
    direct: bool = False

    market: str = "ru"

    limit: int = Field(default=3, ge=1, le=100)
    page: int = Field(default=1, ge=1)

    sorting: Literal["price", "route"] = "price"
    unique: bool = False


class FlightDataDTO(BasePydanticModel):
    flight_number: str
    link: str

    origin: str
    origin_airport: str

    destination: str
    destination_airport: str

    departure_at: str

    airline: str
    price: int
    currency: str | None = None

    gate: str

    return_transfers: int
    transfers: int

    duration: int
    duration_to: int
    duration_back: int


class CheapFlightsResponseDTO(BasePydanticModel):
    success: bool
    currency: str
    data: list[FlightDataDTO]


class RequestPoint(BasePydanticModel):
    lat: float = Field(examples=[43.45])
    lon: float = Field(examples=[39.96])


def now_rfc3339() -> str:
    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


class RouteInfoRequestDTO(BasePydanticModel):
    points: list[RequestPoint] = Field(
        ...,
        description="Список координат точек маршрута",
        examples=[
            [
                {"lat": 54.99770587584445, "lon": 82.79502868652345},
                {"lat": 54.99928130973027, "lon": 82.92137145996095},
                {"lat": 55.04533538802211, "lon": 82.98179626464844},
                {"lat": 55.072470687600536, "lon": 83.04634094238281},
            ]
        ],
    )
    sources: list[int] = Field(
        ...,
        description="Индексы точек отправления в points",
        examples=[[0, 1]],
    )
    targets: list[int] = Field(
        ...,
        description="Индексы точек прибытия в points",
        examples=[[2, 3]],
    )
    transport: Literal[
        "driving",
        "taxi",
        "truck",
        "walking",
        "bicycle",
        "scooter",
        "motorcycle",
        "public_transport",
    ] = "driving"
    start_time: str = Field(
        default_factory=now_rfc3339,
        description="Дата и время начала движения в формате RFC 3339",
        examples=["2020-05-15T15:52:01Z"],
    )


class RouteInfoWithPOIRequestDTO(BasePydanticModel):
    points: list[RequestPoint] = Field(
        ...,
        description="Список координат точек маршрута",
        examples=[
            [
                {"lat": 37.793782, "lon": 44.681283},
            ]
        ],
    )
    interval: int = Field(..., description="Интервал (км)", examples=[200])
    radius: int = Field(..., description="Радиус (м)", examples=[500])
    limit: int = Field(
        ..., description="Лимит промежуточных точек на одно предпочтение"
    )


class POIItem(BasePydanticModel):
    name: Optional[str] = None
    address: Optional[str] = None


class WikipediaItem(BasePydanticModel):
    title: str
    text: Optional[str] = None
    photo: Optional[str] = None
    original: Optional[str] = None


class Waypoint(BasePydanticModel):
    stop: int
    km: float
    coords: list[float]

    address: Optional[str] = None

    # ключи: "кафе", "гостиница" и т.д.
    # значения всегда список (даже если пустой)
    poi: dict[str, list[POIItem]]

    # может быть пустым списком
    wikipedia: list[WikipediaItem]


class RouteFullInfoResponseDTO(BasePydanticModel):
    waypoints: list[Waypoint]


class RouteInfoPointDTO(BasePydanticModel):
    source_id: int
    target_id: int

    distance: int  # метры
    distance_km: float  # километры

    duration: int  # секунды
    duration_minutes: float  # минуты
    duration_hours: float  # часы

    reliability: Optional[float] = None


class RouteInfoResponseDTO(BasePydanticModel):
    status: str = Field(description="Статус ответа")
    routes: list[RouteInfoPointDTO]
    total_distance: int = Field(description="Суммарная дистанция (в метрах)")
    total_distance_km: float = Field(description="Суммарная дистанция (в км)")
    total_duration_minutes: float = Field(
        description="Суммарно затрачиваемое время (в минутах)"
    )
    total_duration_hours: float = Field(
        description="Суммарно затрачиваемое время (в часах)"
    )


# --- Настройка FastAPI ---

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/api/auth",
    description="Построение маршрутов",
)

# --- Зависимости ---


def get_travel_service() -> TravelService:
    return TravelService()


# --- Роуты ---
@router.get(
    "/cities",
    response_model=list[str],
    status_code=status.HTTP_200_OK,
    summary="Доступный список городов",
    description="Доступный список городов",
)
async def get_available_cities(
    service: TravelService = Depends(get_travel_service),
):
    return service.get_available_cities()


@router.get(
    "/global",
    response_model=CheapFlightsResponseDTO,
    status_code=status.HTTP_200_OK,
    summary="Построение глобального маршрута от точки А до точки Б",
    description="Построение глобального маршрута от точки А до точки Б",
)
async def get_global_route(
    data: CheapFlightsRequestDTO = Depends(),
    service: TravelService = Depends(get_travel_service),
):
    payload = await service.get_global_route(data.model_dump(exclude_none=True))
    return CheapFlightsResponseDTO(**payload)


@router.post(
    "/route_matrix_info",
    response_model=RouteInfoResponseDTO,
    status_code=status.HTTP_200_OK,
    summary="Получение информации о расстоянии и времени в пути между точками",
    description="Запрос вернет длину маршрута в метрах (distance) "
    "и время в пути в секундах (duration) для каждой пары точек отправления-прибытия",
)
async def get_route_matrix_info(
    data: RouteInfoRequestDTO,
    service: TravelService = Depends(get_travel_service),
):
    payload = await service.get_route_matrix_info(data.model_dump(exclude_none=True))
    routes = [
        RouteInfoPointDTO(
            source_id=item["source_id"],
            target_id=item["target_id"],
            distance=item["distance"],
            distance_km=round(item["distance"] / 1000, 2),
            duration=item["duration"],
            duration_minutes=math.ceil(item["duration"] / 60),
            duration_hours=math.ceil(item["duration"] / 3600),
            reliability=item.get("reliability"),
        )
        for item in payload.get("routes", [])
    ]
    total_distance = sum(r.distance for r in routes)
    total_distance_km = round(total_distance / 1000, 2)
    total_duration_seconds = sum(r.duration for r in routes)
    total_duration_minutes = math.ceil(total_duration_seconds / 60)
    total_duration_hours = math.ceil(total_duration_seconds / 3600)
    return RouteInfoResponseDTO(
        status="OK",
        routes=routes,
        total_distance=total_distance,
        total_distance_km=total_distance_km,
        total_duration_minutes=total_duration_minutes,
        total_duration_hours=total_duration_hours,
    )


@router.post(
    "/route_full_info",
    response_model=RouteFullInfoResponseDTO,
    status_code=status.HTTP_200_OK,
    summary="Построение POI точек",
    description="Построение POI точек",
)
async def get_route_full_info(
    data: RouteInfoWithPOIRequestDTO,
    service: TravelService = Depends(get_travel_service),
    current_user: User = Depends(get_current_user),
):
    payload = await service.get_route_full_info(
        data.model_dump(exclude_none=True),
        user_id=current_user.id,
    )
    return RouteFullInfoResponseDTO(**payload)


@router.get(
    "/weather_info",
    response_model=dict,
    status_code=status.HTTP_200_OK,
    summary="Получение информации о погоде зная широту и долготу",
    description="Возвращает информацию о погоде",
)
async def get_weather_info(
    lat: float = Query(description="Широта"),
    lon: float = Query(description="Долгота"),
    service: TravelService = Depends(get_travel_service),
):
    return await service.get_weather_info(lat=lat, lon=lon)


class TravelPlanRequestDTO(BasePydanticModel):
    originCity: str
    destinationCity: str
    dayCount: int | None = Field(default=None, ge=2, le=14)
    startDate: str | None = None
    endDate: str | None = None
    skipLlm: bool = False


@router.post(
    "/plan",
    status_code=status.HTTP_200_OK,
    summary="Персональный план поездки (перелёт + дни в городе)",
)
async def post_travel_plan(
    body: TravelPlanRequestDTO,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db_session),
):
    start_d: date | None = None
    end_d: date | None = None
    if body.startDate:
        try:
            start_d = date.fromisoformat(body.startDate[:10])
        except ValueError as e:
            raise HTTPException(status_code=400, detail="Invalid startDate") from e
    if body.endDate:
        try:
            end_d = date.fromisoformat(body.endDate[:10])
        except ValueError as e:
            raise HTTPException(status_code=400, detail="Invalid endDate") from e

    svc = TravelPlanService(db)
    try:
        result = await svc.build_plan(
            user=current_user,
            origin_city=body.originCity,
            destination_city=body.destinationCity,
            start_date=start_d,
            end_date=end_d,
            day_count=body.dayCount,
            skip_llm=body.skipLlm,
        )
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e)) from e

    return {
        "intro": result.intro,
        "usedLlm": result.used_llm,
        "resolvedMode": result.resolved_mode,
        "warnings": result.warnings,
        "flightOffers": result.flight_offers,
        "externalCatalog": result.external_catalog,
        "days": result.days,
    }
