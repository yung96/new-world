import enum

from sqlalchemy import (
    Column,
    DateTime,
    Enum,
    Float,
    ForeignKey,
    Integer,
    String,
    Text,
    func,
)
from sqlalchemy.orm import relationship

from app.models import Base


class BookingStatus(str, enum.Enum):
    pending = "pending"
    confirmed = "confirmed"
    paid = "paid"
    cancelled = "cancelled"
    refunded = "refunded"


class BookingItemStatus(str, enum.Enum):
    pending = "pending"
    confirmed = "confirmed"
    failed = "failed"
    cancelled = "cancelled"
    refunded = "refunded"


class Booking(Base):
    __tablename__ = "bookings"

    id = Column(Integer, primary_key=True, autoincrement=True)
    route_id = Column(
        Integer, ForeignKey("routes.id", ondelete="CASCADE"), nullable=False, index=True
    )
    user_id = Column(
        Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True
    )
    status = Column(
        Enum(BookingStatus, name="booking_status_enum"),
        nullable=False,
        server_default="pending",
    )
    total_price = Column(Float, nullable=True)
    currency = Column(String(3), nullable=True)
    payment_method = Column(String, nullable=True)
    payment_id = Column(String, nullable=True)
    paid_at = Column(DateTime(timezone=True), nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    route = relationship("Route", back_populates="bookings")
    user = relationship("User", foreign_keys=[user_id])
    items = relationship("BookingItem", back_populates="booking", cascade="all, delete-orphan")


class BookingItem(Base):
    __tablename__ = "booking_items"

    id = Column(Integer, primary_key=True, autoincrement=True)
    booking_id = Column(
        Integer,
        ForeignKey("bookings.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    segment_item_id = Column(
        Integer,
        ForeignKey("segment_items.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    external_booking_ref = Column(String, nullable=True)
    status = Column(
        Enum(BookingItemStatus, name="booking_item_status_enum"),
        nullable=False,
        server_default="pending",
    )
    price_locked = Column(Float, nullable=True)
    confirmation_url = Column(String, nullable=True)
    error_message = Column(Text, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    booking = relationship("Booking", back_populates="items")
    segment_item = relationship("SegmentItem", back_populates="booking_items")
