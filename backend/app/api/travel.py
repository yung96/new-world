from typing import Literal, Optional

from fastapi import APIRouter, Depends, status
from fastapi.security import OAuth2PasswordBearer

from pydantic import Field

from app.api.auth import get_current_user
from app.api.base_schema import BasePydanticModel

from app.models.user import User
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


# --- Настройка FastAPI ---

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/api/travel",
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
