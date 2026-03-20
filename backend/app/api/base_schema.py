from typing import Annotated

from pydantic import BaseModel, ConfigDict, Field

ModelId = Annotated[
    int,
    Field(
        None,
        description="Уникальный идентификатор модели",
    ),
]


class BasePydanticModel(BaseModel):
    model_config = ConfigDict(
        from_attributes=True,
        populate_by_name=True,
    )
