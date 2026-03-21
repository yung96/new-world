import enum

from sqlalchemy import (
    BigInteger,
    CheckConstraint,
    Column,
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
from sqlalchemy.orm import relationship

from app.models import Base


class GeoRegionType(str, enum.Enum):
    country = "country"
    region = "region"
    city = "city"
    district = "district"


class GeoRegion(Base):
    __tablename__ = "geo_regions"

    id = Column(BigInteger, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False)
    slug = Column(String, nullable=False, unique=True)
    type = Column(Enum(GeoRegionType, name="geo_region_type_enum"), nullable=False)
    parent_id = Column(
        BigInteger,
        ForeignKey("geo_regions.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    polygon = Column(Text, nullable=True)
    centroid = Column(Text, nullable=True)
    population = Column(Integer, nullable=True)
    timezone = Column(String, nullable=True)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    children = relationship(
        "GeoRegion",
        foreign_keys="GeoRegion.parent_id",
        back_populates="parent",
    )
    parent = relationship(
        "GeoRegion",
        foreign_keys="GeoRegion.parent_id",
        back_populates="children",
        remote_side="GeoRegion.id",
    )

    weather = relationship("WeatherMonthly", back_populates="region", cascade="all, delete-orphan")
    outbound_links = relationship(
        "TransportLink",
        foreign_keys="TransportLink.from_id",
        back_populates="from_region",
        cascade="all, delete-orphan",
    )
    inbound_links = relationship(
        "TransportLink",
        foreign_keys="TransportLink.to_id",
        back_populates="to_region",
        cascade="all, delete-orphan",
    )


class WeatherMonthly(Base):
    __tablename__ = "weather_monthly"

    __table_args__ = (
        CheckConstraint("month >= 1 AND month <= 12", name="weather_monthly_month_check"),
    )

    region_id = Column(
        BigInteger,
        ForeignKey("geo_regions.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    month = Column(SmallInteger, primary_key=True, nullable=False)
    temp_min = Column(Float, nullable=True)
    temp_max = Column(Float, nullable=True)
    rain_mm = Column(Float, nullable=True)
    sunny_days = Column(SmallInteger, nullable=True)
    description = Column(String, nullable=True)
    fetched_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    region = relationship("GeoRegion", back_populates="weather")


class TransportLink(Base):
    __tablename__ = "transport_links"

    __table_args__ = (
        CheckConstraint(
            "kind IN ('plane', 'train', 'bus', 'ferry')",
            name="transport_links_kind_check",
        ),
        UniqueConstraint("from_id", "to_id", "kind", name="uq_transport_links_from_to_kind"),
    )

    id = Column(Integer, primary_key=True, autoincrement=True)
    from_id = Column(
        BigInteger,
        ForeignKey("geo_regions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    to_id = Column(
        BigInteger,
        ForeignKey("geo_regions.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    kind = Column(String, nullable=False)
    duration_min = Column(Integer, nullable=True)
    price_from = Column(Integer, nullable=True)
    aviasales_url = Column(String, nullable=True)
    tutu_url = Column(String, nullable=True)
    updated_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    from_region = relationship(
        "GeoRegion",
        foreign_keys="TransportLink.from_id",
        back_populates="outbound_links",
    )
    to_region = relationship(
        "GeoRegion",
        foreign_keys="TransportLink.to_id",
        back_populates="inbound_links",
    )
