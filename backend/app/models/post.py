import enum

from sqlalchemy import Boolean, Column, DateTime, Enum, Float, ForeignKey, Integer, Numeric, String, Text, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import post_interests


class Season(str, enum.Enum):
    spring = "spring"
    summer = "summer"
    autumn = "autumn"
    winter = "winter"


class PriceLevel(str, enum.Enum):
    low = "low"
    mid = "mid"
    high = "high"


class Post(Base):
    __tablename__ = "posts"

    id = Column(Integer, primary_key=True, autoincrement=True)
    author_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    city = Column(String, nullable=True)
    geo_lat = Column(Float, nullable=True)
    geo_lng = Column(Float, nullable=True)
    season = Column(Enum(Season, name="season_enum"), nullable=False)

    region_id = Column(Integer, ForeignKey("geo_regions.id", ondelete="SET NULL"), nullable=True, index=True)
    address = Column(String, nullable=True)
    phone = Column(String, nullable=True)
    email = Column(String, nullable=True)
    website = Column(String, nullable=True)
    need_car = Column(Boolean, nullable=False, default=False)
    price_level = Column(Enum(PriceLevel, name="price_level_enum"), nullable=True)
    duration_hours = Column(Float, nullable=True)
    best_angle = Column(Text, nullable=True)
    partner_id = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"), nullable=True, index=True)
    verified = Column(Boolean, nullable=False, default=False)
    rating_avg = Column(Numeric(3, 2), nullable=False, default=0)
    reviews_count = Column(Integer, nullable=False, default=0)

    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())
    updated_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now(), onupdate=func.now())

    author = relationship("User", foreign_keys=[author_id], back_populates="posts")
    partner = relationship("User", foreign_keys=[partner_id])
    reviews = relationship("Review", back_populates="post", cascade="all, delete-orphan")
    media = relationship("PostMedia", back_populates="post", cascade="all, delete-orphan", order_by="PostMedia.position")
    schedule = relationship("PlaceSchedule", back_populates="post", cascade="all, delete-orphan")
    schedule_overrides = relationship("PlaceScheduleOverride", back_populates="post", cascade="all, delete-orphan")
    interests = relationship("Interest", secondary=post_interests, back_populates="posts")
