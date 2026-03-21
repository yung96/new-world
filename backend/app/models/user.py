from sqlalchemy import Column, DateTime, Integer, String, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import (
    user_achievements,
    user_favorite_posts,
    user_interests,
    user_subscriptions,
)


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, autoincrement=True)
    phone = Column(String, nullable=False, unique=True, index=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    achievements = relationship(
        "Achievement", secondary=user_achievements, back_populates="users"
    )
    posts = relationship("Post", back_populates="author", cascade="all, delete-orphan")
    reviews = relationship(
        "Review", back_populates="author", cascade="all, delete-orphan"
    )
    interests = relationship(
        "Interest", secondary=user_interests, back_populates="users"
    )
    favorite_posts = relationship(
        "Post", secondary=user_favorite_posts, back_populates="favorited_by_users"
    )

    following = relationship(
        "User",
        secondary=user_subscriptions,
        primaryjoin=id == user_subscriptions.c.subscriber_id,
        secondaryjoin=id == user_subscriptions.c.following_id,
        backref="followers",
    )
