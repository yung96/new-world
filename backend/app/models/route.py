import enum

from sqlalchemy import (
    Boolean,
    CheckConstraint,
    Column,
    Date,
    DateTime,
    Enum,
    Float,
    ForeignKey,
    Integer,
    SmallInteger,
    String,
    Text,
    UniqueConstraint,
    func,
)
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship

from app.models import Base


class RouteStatus(str, enum.Enum):
    draft = "draft"
    scoring = "scoring"
    distances = "distances"
    enriching = "enriching"
    weather = "weather"
    narrating = "narrating"
    ready = "ready"
    stale = "stale"
    booking = "booking"
    partially_booked = "partially_booked"
    booked = "booked"
    completed = "completed"
    cancelled = "cancelled"


class PriceStatus(str, enum.Enum):
    fresh = "fresh"
    stale = "stale"
    expired = "expired"
    unavailable = "unavailable"


class SegmentItemType(str, enum.Enum):
    leg = "leg"
    stay = "stay"
    transfer = "transfer"
    car_rental = "car_rental"
    day = "day"
    experience = "experience"


class PinType(str, enum.Enum):
    city = "city"
    stay = "stay"
    experience = "experience"
    transport_hub = "transport_hub"
    photo_spot = "photo_spot"
    food = "food"
    custom = "custom"


class PinSource(str, enum.Enum):
    auto = "auto"
    user = "user"
    editor = "editor"
    ai = "ai"


class Route(Base):
    __tablename__ = "routes"

    id = Column(Integer, primary_key=True, autoincrement=True)
    author_id = Column(
        Integer, ForeignKey("users.id", ondelete="SET NULL"), nullable=True, index=True
    )
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    cover_url = Column(String, nullable=True)
    narrative = Column(Text, nullable=True)
    total_days = Column(Integer, nullable=True)
    total_price = Column(Float, nullable=True)
    total_price_status = Column(
        Enum(PriceStatus, name="route_price_status_enum"),
        nullable=False,
        server_default="fresh",
    )
    total_experiences = Column(Integer, nullable=False, server_default="0")
    total_hotels = Column(Integer, nullable=False, server_default="0")
    total_transports = Column(Integer, nullable=False, server_default="0")
    share_token = Column(String, nullable=True, unique=True, index=True)
    params = Column(JSONB, nullable=True)
    status = Column(
        Enum(RouteStatus, name="route_status_enum"),
        nullable=False,
        server_default="draft",
    )
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    segments = relationship("RouteSegment", back_populates="route", cascade="all, delete-orphan", order_by="RouteSegment.position")
    pins = relationship("RoutePin", back_populates="route", cascade="all, delete-orphan")
    bookings = relationship("Booking", back_populates="route", cascade="all, delete-orphan")


class RouteSegment(Base):
    __tablename__ = "route_segments"

    id = Column(Integer, primary_key=True, autoincrement=True)
    route_id = Column(
        Integer, ForeignKey("routes.id", ondelete="CASCADE"), nullable=False, index=True
    )
    position = Column(SmallInteger, nullable=False)
    city_id = Column(
        Integer, ForeignKey("geo_regions.id", ondelete="SET NULL"), nullable=True, index=True
    )
    title = Column(String, nullable=True)
    description = Column(Text, nullable=True)
    narrative = Column(Text, nullable=True)
    date_from = Column(Date, nullable=True)
    date_to = Column(Date, nullable=True)
    photos = Column(JSONB, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    route = relationship("Route", back_populates="segments")
    items = relationship("SegmentItem", back_populates="segment", cascade="all, delete-orphan", order_by="SegmentItem.position")
    pins = relationship("RoutePin", back_populates="segment")


class SegmentItem(Base):
    __tablename__ = "segment_items"

    id = Column(Integer, primary_key=True, autoincrement=True)
    segment_id = Column(
        Integer,
        ForeignKey("route_segments.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    parent_id = Column(
        Integer,
        ForeignKey("segment_items.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    type = Column(
        Enum(SegmentItemType, name="segment_item_type_enum"), nullable=False
    )
    position = Column(SmallInteger, nullable=False, server_default="0")
    price = Column(Float, nullable=True)
    price_currency = Column(String(3), nullable=True)
    price_original = Column(Float, nullable=True)
    price_fetched_at = Column(DateTime(timezone=True), nullable=True)
    price_status = Column(
        Enum(PriceStatus, name="segment_item_price_status_enum"),
        nullable=False,
        server_default="fresh",
    )
    provider_name = Column(String, nullable=True)
    provider_url = Column(String, nullable=True)
    ai_comment = Column(Text, nullable=True)
    details = Column(JSONB, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    segment = relationship("RouteSegment", back_populates="items")
    children = relationship(
        "SegmentItem",
        foreign_keys="SegmentItem.parent_id",
        back_populates="parent",
        cascade="all, delete-orphan",
    )
    parent = relationship(
        "SegmentItem",
        foreign_keys=[parent_id],
        back_populates="children",
        remote_side=[id],
    )
    booking_items = relationship("BookingItem", back_populates="segment_item", cascade="all, delete-orphan")
    pins = relationship("RoutePin", back_populates="segment_item")


class RoutePin(Base):
    __tablename__ = "route_pins"

    id = Column(Integer, primary_key=True, autoincrement=True)
    route_id = Column(
        Integer, ForeignKey("routes.id", ondelete="CASCADE"), nullable=False, index=True
    )
    segment_id = Column(
        Integer,
        ForeignKey("route_segments.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    segment_item_id = Column(
        Integer,
        ForeignKey("segment_items.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    label = Column(String, nullable=True)
    pin_type = Column(
        Enum(PinType, name="pin_type_enum"), nullable=False
    )
    lat = Column(Float, nullable=False)
    lng = Column(Float, nullable=False)
    icon = Column(String, nullable=True)
    color = Column(String, nullable=True)
    position = Column(Integer, nullable=False, server_default="0")
    zoom_level = Column(SmallInteger, nullable=True)
    is_visible = Column(Boolean, nullable=False, server_default="true")
    source = Column(
        Enum(PinSource, name="pin_source_enum"),
        nullable=False,
        server_default="auto",
    )
    is_persistent = Column(Boolean, nullable=False, server_default="true")
    created_by = Column(
        Integer, ForeignKey("users.id", ondelete="SET NULL"), nullable=True, index=True
    )
    notes = Column(Text, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    route = relationship("Route", back_populates="pins")
    segment = relationship("RouteSegment", back_populates="pins")
    segment_item = relationship("SegmentItem", back_populates="pins")
    creator = relationship("User", foreign_keys=[created_by])
