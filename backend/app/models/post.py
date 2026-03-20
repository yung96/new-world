import enum

from sqlalchemy import Column, DateTime, Enum, Float, ForeignKey, Integer, String, Text, func
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import post_interests, user_favorite_posts


class Season(str, enum.Enum):
    spring = "spring"
    summer = "summer"
    autumn = "autumn"
    winter = "winter"


class Post(Base):
    __tablename__ = "posts"

    id = Column(Integer, primary_key=True, autoincrement=True)
    author_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    media_urls = Column(JSONB, nullable=False, default=list)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    geo_lat = Column(Float, nullable=True)
    geo_lng = Column(Float, nullable=True)
    season = Column(Enum(Season, name="season_enum"), nullable=False)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())
    updated_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now(), onupdate=func.now())

    author = relationship("User", back_populates="posts")
    reviews = relationship("Review", back_populates="post", cascade="all, delete-orphan")
    interests = relationship("Interest", secondary=post_interests, back_populates="posts")
    favorited_by_users = relationship(
        "User", secondary=user_favorite_posts, back_populates="favorite_posts"
    )
