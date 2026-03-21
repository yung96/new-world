from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Table, UniqueConstraint, text

from app.models import Base


user_achievements = Table(
    "user_achievements",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("achievement_id", Integer, ForeignKey("achievements.id", ondelete="CASCADE"), primary_key=True),
)


user_interests = Table(
    "user_interests",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("interest_id", Integer, ForeignKey("interests.id", ondelete="CASCADE"), primary_key=True),
    Column("weight", Integer, nullable=False, server_default=text("1")),
)


post_interests = Table(
    "post_interests",
    Base.metadata,
    Column("post_id", Integer, ForeignKey("posts.id", ondelete="CASCADE"), primary_key=True),
    Column("interest_id", Integer, ForeignKey("interests.id", ondelete="CASCADE"), primary_key=True),
)


user_friends = Table(
    "user_friends",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("friend_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    UniqueConstraint("user_id", "friend_id", name="uq_user_friend_pair"),
)


user_favorite_posts = Table(
    "user_favorite_posts",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("post_id", Integer, ForeignKey("posts.id", ondelete="CASCADE"), primary_key=True),
    UniqueConstraint("user_id", "post_id", name="uq_user_favorite_post_pair"),
)


user_swiped_posts = Table(
    "user_swiped_posts",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("users.id", ondelete="CASCADE"), primary_key=True),
    Column("post_id", Integer, ForeignKey("posts.id", ondelete="CASCADE"), primary_key=True),
    Column("direction", String, nullable=False),
    Column("created_at", DateTime(timezone=True), nullable=False, server_default=text("now()")),
    UniqueConstraint("user_id", "post_id", name="uq_user_swiped_post_pair"),
)
