"""
Pydantic-схемы ответа LLM для планирования поездки (structured output).
"""

from typing import Literal

from pydantic import Field

from app.api.base_schema import BasePydanticModel


class TravelPlanBlockLlm(BasePydanticModel):
    block_type: Literal["flight", "internal_post", "external_poi", "free_time"]
    flight_offer_index: int | None = None
    post_id: int | None = None
    external_candidate_index: int | None = None
    rationale: str = Field(
        ...,
        min_length=8,
        max_length=1200,
        description="Краткое пояснение для пользователя с отсылкой к его интересам и весам",
    )
    highlighted_interest_ids: list[int] = Field(
        default_factory=list,
        description="id интересов из userInterests, которые объясняют выбор блока",
    )


class TravelPlanDayLlm(BasePydanticModel):
    day_index: int = Field(..., ge=1)
    theme: str = Field(..., min_length=2, max_length=200)
    blocks: list[TravelPlanBlockLlm]


class TravelPlanLlmOut(BasePydanticModel):
    intro: str = Field(
        ...,
        min_length=10,
        max_length=2000,
        description="Вступление: учитывай интересы пользователя и их веса, обращение на «вы»",
    )
    resolved_mode: str = Field(
        default="global_then_local",
        description="Режим: global_then_local для перелёта + город назначения",
    )
    days: list[TravelPlanDayLlm]
    warnings: list[str] = Field(default_factory=list)
