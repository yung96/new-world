import enum

from sqlalchemy import (
    CheckConstraint,
    Column,
    Date,
    DateTime,
    Enum,
    ForeignKey,
    Integer,
    String,
    Table,
    Text,
)
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.models import Base


# ---------------------------------------------------------------------------
# post_interests — kept as a plain Table; used as secondary in Post / Interest
# ---------------------------------------------------------------------------

post_interests = Table(
    "post_interests",
    Base.metadata,
    Column(
        "post_id",
        Integer,
        ForeignKey("posts.id", ondelete="CASCADE"),
        primary_key=True,
    ),
    Column(
        "interest_id",
        Integer,
        ForeignKey("interests.id", ondelete="CASCADE"),
        primary_key=True,
    ),
)


# ---------------------------------------------------------------------------
# Follow  (replaces user_subscriptions)
# ---------------------------------------------------------------------------
class Follow(Base):
    __tablename__ = "user_subscriptions"

    follower_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    following_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    __table_args__ = (
        CheckConstraint(
            "follower_id != following_id", name="ck_user_subscriptions_no_self"
        ),
    )

    follower = relationship("User", foreign_keys=[follower_id], back_populates="following_rels")
    following = relationship("User", foreign_keys=[following_id], back_populates="follower_rels")


# Expose underlying Table for any secondary= usage that may still reference it
user_subscriptions = Follow.__table__


# ---------------------------------------------------------------------------
# Invite
# ---------------------------------------------------------------------------
class Invite(Base):
    __tablename__ = "invites"

    id = Column(Integer, primary_key=True, autoincrement=True)
    inviter_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    invitee_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    code = Column(String, nullable=False, unique=True, index=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    inviter = relationship("User", foreign_keys=[inviter_id], back_populates="sent_invites")
    invitee = relationship("User", foreign_keys=[invitee_id], back_populates="received_invite")


# ---------------------------------------------------------------------------
# UserPlaceStatus  (replaces user_favorite_posts)
# ---------------------------------------------------------------------------
class PlaceStatusEnum(str, enum.Enum):
    visited = "visited"
    want = "want"
    planned = "planned"


class UserPlaceStatus(Base):
    __tablename__ = "user_place_statuses"

    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    post_id = Column(
        Integer,
        ForeignKey("posts.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    status = Column(
        Enum(PlaceStatusEnum, name="place_status_enum"),
        nullable=False,
    )
    planned_date = Column(Date, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    user = relationship("User", foreign_keys=[user_id], back_populates="place_statuses")
    post = relationship("Post", foreign_keys=[post_id])


# Keep old name importable so nothing outside these two files hard-crashes
# during the migration window.
user_favorite_posts = UserPlaceStatus.__table__


# ---------------------------------------------------------------------------
# UserSwipedPost  (replaces user_swiped_posts Table)
# ---------------------------------------------------------------------------
class SwipeDirection(str, enum.Enum):
    left = "left"
    right = "right"
    up = "up"


class UserSwipedPost(Base):
    __tablename__ = "user_swiped_posts"

    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    post_id = Column(
        Integer,
        ForeignKey("posts.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    direction = Column(
        Enum(SwipeDirection, name="swipe_direction_enum"),
        nullable=False,
    )
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    user = relationship("User", foreign_keys=[user_id], back_populates="swiped_posts")
    post = relationship("Post", foreign_keys=[post_id])


user_swiped_posts = UserSwipedPost.__table__


# ---------------------------------------------------------------------------
# UserAchievement  (replaces user_achievements Table)
# ---------------------------------------------------------------------------
class UserAchievement(Base):
    __tablename__ = "user_achievements"

    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    achievement_id = Column(
        Integer,
        ForeignKey("achievements.id", ondelete="CASCADE"),
        primary_key=True,
        nullable=False,
    )
    earned_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    # viewonly relationships for direct access to earned_at;
    # the bidirectional many-to-many is handled via secondary= on User/Achievement
    user = relationship(
        "User",
        foreign_keys=[user_id],
        overlaps="achievements,users",
    )
    achievement = relationship(
        "Achievement",
        foreign_keys=[achievement_id],
        overlaps="achievements,users",
    )


# Expose underlying Table so Achievement model's secondary= still works
user_achievements = UserAchievement.__table__


# ---------------------------------------------------------------------------
# user_interests — kept as a plain Table; used as secondary in User / Interest
# ---------------------------------------------------------------------------
user_interests = Table(
    "user_interests",
    Base.metadata,
    Column(
        "user_id",
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        primary_key=True,
    ),
    Column(
        "interest_id",
        Integer,
        ForeignKey("interests.id", ondelete="CASCADE"),
        primary_key=True,
    ),
    Column("weight", Integer, nullable=False, server_default="1"),
)


# ---------------------------------------------------------------------------
# FilterPreset
# ---------------------------------------------------------------------------
class FilterPreset(Base):
    __tablename__ = "filter_presets"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    name = Column(String, nullable=False)
    date_from = Column(Date, nullable=True)
    date_to = Column(Date, nullable=True)
    group_type = Column(String, nullable=True)
    group_size = Column(Integer, nullable=True)
    transport = Column(String, nullable=True)
    budget = Column(String, nullable=True)
    interests = Column(JSONB, nullable=True)
    pace = Column(String, nullable=True)
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    user = relationship("User", back_populates="filter_presets")


# ---------------------------------------------------------------------------
# Report
# ---------------------------------------------------------------------------
class ReportStatusEnum(str, enum.Enum):
    pending = "pending"
    resolved = "resolved"
    rejected = "rejected"


class Report(Base):
    __tablename__ = "reports"

    id = Column(Integer, primary_key=True, autoincrement=True)
    reporter_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True,
    )
    target_type = Column(String, nullable=False)  # "user" | "post" | "review"
    target_id = Column(Integer, nullable=False, index=True)
    reason = Column(Text, nullable=False)
    status = Column(
        Enum(ReportStatusEnum, name="report_status_enum"),
        nullable=False,
        server_default="pending",
    )
    created_at = Column(
        DateTime(timezone=True), nullable=False, server_default=func.now()
    )

    reporter = relationship("User", back_populates="reports")
