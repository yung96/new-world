import enum

from sqlalchemy import Column, DateTime, Enum, ForeignKey, Integer, String, UniqueConstraint, func
from sqlalchemy.orm import relationship

from app.models import Base


class TagCategory(str, enum.Enum):
    interest = "interest"
    audience = "audience"
    format = "format"
    season = "season"


class Tag(Base):
    __tablename__ = "tags"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False, unique=True)
    emoji = Column(String, nullable=True)
    category = Column(Enum(TagCategory, name="tag_category_enum"), nullable=False)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    place_tags = relationship("PlaceTag", back_populates="tag", cascade="all, delete-orphan")
    user_tags = relationship("UserTag", back_populates="tag", cascade="all, delete-orphan")


class PlaceTag(Base):
    __tablename__ = "place_tags"

    post_id = Column(
        Integer,
        ForeignKey("posts.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    tag_id = Column(
        Integer,
        ForeignKey("tags.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    weight = Column(Integer, nullable=False, default=1)

    tag = relationship("Tag", back_populates="place_tags")


class UserTag(Base):
    __tablename__ = "user_tags"

    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    tag_id = Column(
        Integer,
        ForeignKey("tags.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    weight = Column(Integer, nullable=False, default=1)

    tag = relationship("Tag", back_populates="user_tags")
