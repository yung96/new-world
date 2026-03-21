from sqlalchemy import Boolean, CheckConstraint, Column, Date, DateTime, Float, ForeignKey, Integer, SmallInteger, String, Time, func
from sqlalchemy.orm import relationship

from app.models import Base


class PostMedia(Base):
    __tablename__ = "post_media"

    id = Column(Integer, primary_key=True, autoincrement=True)
    post_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), nullable=False, index=True)
    url = Column(String, nullable=False)
    alt = Column(String, nullable=True)
    position = Column(SmallInteger, nullable=False, default=0)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    post = relationship("Post", back_populates="media")


class PlaceSchedule(Base):
    __tablename__ = "place_schedules"
    __table_args__ = (
        CheckConstraint("day_of_week >= 0 AND day_of_week <= 6", name="ck_place_schedules_day_of_week"),
    )

    id = Column(Integer, primary_key=True, autoincrement=True)
    post_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), nullable=False, index=True)
    day_of_week = Column(SmallInteger, nullable=False)
    open_time = Column(Time, nullable=True)
    close_time = Column(Time, nullable=True)
    is_closed = Column(Boolean, nullable=False, default=False)

    post = relationship("Post", back_populates="schedule")


class PlaceScheduleOverride(Base):
    __tablename__ = "place_schedule_overrides"

    id = Column(Integer, primary_key=True, autoincrement=True)
    post_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), nullable=False, index=True)
    date = Column(Date, nullable=False)
    is_closed = Column(Boolean, nullable=False, default=False)
    open_time = Column(Time, nullable=True)
    close_time = Column(Time, nullable=True)
    reason = Column(String, nullable=True)

    post = relationship("Post", back_populates="schedule_overrides")


class SimilarPlace(Base):
    __tablename__ = "similar_places"

    place_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), primary_key=True)
    similar_place_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), primary_key=True)
    score = Column(Float, nullable=False, default=0)

    place = relationship("Post", foreign_keys=[place_id])
    similar_place = relationship("Post", foreign_keys=[similar_place_id])
