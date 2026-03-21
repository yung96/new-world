from sqlalchemy import (
    Boolean,
    Column,
    DateTime,
    ForeignKey,
    Integer,
    PrimaryKeyConstraint,
    SmallInteger,
    String,
    Text,
    func,
)
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship

from app.models import Base


class PromptTemplate(Base):
    __tablename__ = "prompt_templates"

    id = Column(Integer, primary_key=True, autoincrement=True)
    slug = Column(String, nullable=False, unique=True, index=True)
    category = Column(String, nullable=False, index=True)
    scenario = Column(JSONB, nullable=True)
    transport_context = Column(String, nullable=True)
    weather_context = Column(String, nullable=True)
    group_context = Column(String, nullable=True)
    template_text = Column(Text, nullable=False)
    priority = Column(Integer, nullable=False, server_default="0")
    is_active = Column(Boolean, nullable=False, server_default="true")
    version = Column(Integer, nullable=False, server_default="1")
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    composition_items = relationship(
        "PromptCompositionItem",
        back_populates="template",
        cascade="all, delete-orphan",
    )


class PromptComposition(Base):
    __tablename__ = "prompt_compositions"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False)
    scenario = Column(JSONB, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    items = relationship(
        "PromptCompositionItem",
        back_populates="composition",
        cascade="all, delete-orphan",
        order_by="PromptCompositionItem.position",
    )
    logs = relationship("PromptLog", back_populates="composition")


class PromptCompositionItem(Base):
    __tablename__ = "prompt_composition_items"

    __table_args__ = (
        PrimaryKeyConstraint("composition_id", "template_id"),
    )

    composition_id = Column(
        Integer,
        ForeignKey("prompt_compositions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    template_id = Column(
        Integer,
        ForeignKey("prompt_templates.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    position = Column(SmallInteger, nullable=False, server_default="0")

    composition = relationship("PromptComposition", back_populates="items")
    template = relationship("PromptTemplate", back_populates="composition_items")


class PromptLog(Base):
    __tablename__ = "prompt_logs"

    id = Column(Integer, primary_key=True, autoincrement=True)
    route_id = Column(
        Integer, ForeignKey("routes.id", ondelete="CASCADE"), nullable=False, index=True
    )
    composition_id = Column(
        Integer,
        ForeignKey("prompt_compositions.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    template_ids = Column(JSONB, nullable=True)
    assembled_prompt = Column(Text, nullable=True)
    llm_response = Column(Text, nullable=True)
    model = Column(String, nullable=True)
    tokens_in = Column(Integer, nullable=True)
    tokens_out = Column(Integer, nullable=True)
    latency_ms = Column(Integer, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    route = relationship("Route", foreign_keys=[route_id])
    composition = relationship("PromptComposition", back_populates="logs")
