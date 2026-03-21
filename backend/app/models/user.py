import enum

from sqlalchemy import Column, DateTime, Enum, Integer, String, Text, func
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import user_achievements, user_interests


class UserRole(str, enum.Enum):
    tourist = "tourist"
    owner = "owner"
    both = "both"


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, autoincrement=True)
    phone = Column(String, nullable=False, unique=True, index=True)
    name = Column(String, nullable=True)
    avatar_url = Column(String, nullable=True)
    bio = Column(Text, nullable=True)
    role = Column(
        Enum(UserRole, name="user_role_enum"),
        nullable=False,
        server_default="tourist",
    )
    taste_profile = Column(JSONB, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )
    updated_at = Column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    # -----------------------------------------------------------------------
    # Core content relationships
    # -----------------------------------------------------------------------
    posts = relationship("Post", foreign_keys="Post.author_id", back_populates="author", cascade="all, delete-orphan")
    reviews = relationship(
        "Review", back_populates="author", cascade="all, delete-orphan"
    )

    # -----------------------------------------------------------------------
    # Interests — many-to-many via secondary Table (user_interests)
    # -----------------------------------------------------------------------
    interests = relationship(
        "Interest", secondary=user_interests, back_populates="users"
    )

    # -----------------------------------------------------------------------
    # Achievements — many-to-many via secondary Table (user_achievements.__table__)
    # Use UserAchievement ORM model directly when earned_at is needed.
    # -----------------------------------------------------------------------
    achievements = relationship(
        "Achievement", secondary=user_achievements, back_populates="users"
    )

    # -----------------------------------------------------------------------
    # Place statuses — replaces favorite_posts (via UserPlaceStatus ORM model)
    # -----------------------------------------------------------------------
    place_statuses = relationship(
        "UserPlaceStatus", back_populates="user", cascade="all, delete-orphan"
    )

    # -----------------------------------------------------------------------
    # Swiped posts (via UserSwipedPost ORM model)
    # -----------------------------------------------------------------------
    swiped_posts = relationship(
        "UserSwipedPost", back_populates="user", cascade="all, delete-orphan"
    )

    # -----------------------------------------------------------------------
    # Follow graph (via Follow ORM model)
    # following_rels — Follow rows where this user is the actor (people I follow)
    # follower_rels  — Follow rows where this user is the target (people who follow me)
    # -----------------------------------------------------------------------
    following_rels = relationship(
        "Follow",
        foreign_keys="Follow.follower_id",
        back_populates="follower",
        cascade="all, delete-orphan",
    )
    follower_rels = relationship(
        "Follow",
        foreign_keys="Follow.following_id",
        back_populates="following",
        cascade="all, delete-orphan",
    )

    # -----------------------------------------------------------------------
    # Invites
    # -----------------------------------------------------------------------
    sent_invites = relationship(
        "Invite",
        foreign_keys="Invite.inviter_id",
        back_populates="inviter",
        cascade="all, delete-orphan",
    )
    received_invite = relationship(
        "Invite",
        foreign_keys="Invite.invitee_id",
        back_populates="invitee",
        uselist=False,
    )

    # -----------------------------------------------------------------------
    # Filter presets
    # -----------------------------------------------------------------------
    filter_presets = relationship(
        "FilterPreset", back_populates="user", cascade="all, delete-orphan"
    )

    # -----------------------------------------------------------------------
    # Reports filed by this user
    # -----------------------------------------------------------------------
    reports = relationship(
        "Report", back_populates="reporter", cascade="all, delete-orphan"
    )
