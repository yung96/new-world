"""Structured LLM output для локального маршрута (namespace ivan-alt)."""

from pydantic import Field

from app.api.base_schema import BasePydanticModel


class IvanAltLocalRouteStopLlm(BasePydanticModel):
    post_id: int = Field(..., description="id карточки места из переданного списка")
    caption: str = Field(
        ...,
        min_length=8,
        max_length=900,
        description="Короткая подпись на «вы» с отсылкой к интересам пользователя",
    )
    highlighted_interest_ids: list[int] = Field(
        default_factory=list,
        description="id интересов из контекста, которые лучше объясняют остановку",
    )


class IvanAltLocalRouteLlmOut(BasePydanticModel):
    route_title: str = Field(
        ...,
        min_length=2,
        max_length=200,
        description="Название маршрута",
    )
    intro: str | None = Field(
        default=None,
        max_length=1500,
        description="Вступление с учётом интересов",
    )
    ordered_stops: list[IvanAltLocalRouteStopLlm] = Field(
        ...,
        description="Все места из входа, каждое ровно один раз, порядок — посещение",
    )
