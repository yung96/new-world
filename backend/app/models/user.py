from sqlalchemy import Column, DateTime, Integer, String, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import user_achievements, user_friends, user_interests


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

    friends = relationship(
        "User",
        secondary=user_friends,
        primaryjoin=id == user_friends.c.user_id,
        secondaryjoin=id == user_friends.c.friend_id,
        backref="friend_of",
    )
    sent_friend_requests = relationship(
        "FriendRequest",
        foreign_keys="FriendRequest.requester_id",
        back_populates="requester",
        cascade="all, delete-orphan",
    )
    received_friend_requests = relationship(
        "FriendRequest",
        foreign_keys="FriendRequest.receiver_id",
        back_populates="receiver",
        cascade="all, delete-orphan",
    )
