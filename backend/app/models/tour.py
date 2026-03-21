import enum

from sqlalchemy import Column, DateTime, Enum, Float, ForeignKey, Integer, SmallInteger, String, Text, func
from sqlalchemy.orm import relationship

from app.models import Base


class ServiceType(str, enum.Enum):
    transport = "transport"
    food = "food"
    activity = "activity"
    guide = "guide"
    other = "other"


class Tour(Base):
    __tablename__ = "tours"

    id = Column(Integer, primary_key=True, autoincrement=True)
    post_id = Column(
        Integer,
        ForeignKey("posts.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    price = Column(Float, nullable=True)
    duration_min = Column(Integer, nullable=True)
    max_group_size = Column(Integer, nullable=True)
    guide_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    publisher_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    services = relationship(
        "Service",
        secondary="tour_services",
        back_populates="tours",
    )
    tour_service_rels = relationship(
        "TourService",
        back_populates="tour",
        cascade="all, delete-orphan",
        overlaps="services",
    )


class Service(Base):
    __tablename__ = "services"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False)
    type = Column(Enum(ServiceType, name="service_type_enum"), nullable=False)
    duration_min = Column(Integer, nullable=True)
    description = Column(Text, nullable=True)

    tours = relationship(
        "Tour",
        secondary="tour_services",
        back_populates="services",
        overlaps="tour_service_rels",
    )
    tour_service_rels = relationship(
        "TourService",
        back_populates="service",
        cascade="all, delete-orphan",
        overlaps="services,tours",
    )


class TourService(Base):
    __tablename__ = "tour_services"

    tour_id = Column(
        Integer,
        ForeignKey("tours.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    service_id = Column(
        Integer,
        ForeignKey("services.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    position = Column(SmallInteger, nullable=False, default=0)

    tour = relationship("Tour", back_populates="tour_service_rels", overlaps="services,tours")
    service = relationship("Service", back_populates="tour_service_rels", overlaps="services,tours")
