"""init social schema

Revision ID: 001
Revises:
Create Date: 2026-03-20 13:00:00.000000
"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql


# revision identifiers, used by Alembic.
revision: str = "001"
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    season_enum = postgresql.ENUM(
        "spring",
        "summer",
        "autumn",
        "winter",
        name="season_enum",
        create_type=False,
    )
    friend_request_status_enum = postgresql.ENUM(
        "pending",
        "accepted",
        "rejected",
        name="friend_request_status_enum",
        create_type=False,
    )
    op.execute(
        "DO $$ BEGIN CREATE TYPE season_enum AS ENUM ('spring', 'summer', 'autumn', 'winter'); "
        "EXCEPTION WHEN duplicate_object THEN NULL; END $$;"
    )
    op.execute(
        "DO $$ BEGIN CREATE TYPE friend_request_status_enum AS ENUM ('pending', 'accepted', 'rejected'); "
        "EXCEPTION WHEN duplicate_object THEN NULL; END $$;"
    )

    op.create_table(
        "users",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("phone", sa.String(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(op.f("ix_users_phone"), "users", ["phone"], unique=True)

    op.create_table(
        "achievements",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("name", sa.String(), nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("name"),
    )

    op.create_table(
        "interests",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("name", sa.String(), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("name"),
    )
    op.create_index(op.f("ix_interests_name"), "interests", ["name"], unique=True)

    op.create_table(
        "posts",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("author_id", sa.Integer(), nullable=False),
        sa.Column(
            "media_urls",
            sa.dialects.postgresql.JSONB(astext_type=sa.Text()),
            nullable=False,
            server_default=sa.text("'[]'::jsonb"),
        ),
        sa.Column("title", sa.String(), nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("geo_lat", sa.Float(), nullable=True),
        sa.Column("geo_lng", sa.Float(), nullable=True),
        sa.Column(
            "tags",
            sa.dialects.postgresql.JSONB(astext_type=sa.Text()),
            nullable=False,
            server_default=sa.text("'[]'::jsonb"),
        ),
        sa.Column(
            "season",
            season_enum,
            nullable=False,
        ),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.ForeignKeyConstraint(["author_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(op.f("ix_posts_author_id"), "posts", ["author_id"], unique=False)

    op.create_table(
        "reviews",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("author_id", sa.Integer(), nullable=False),
        sa.Column("post_id", sa.Integer(), nullable=False),
        sa.Column("rating", sa.Integer(), nullable=False),
        sa.Column("comment", sa.Text(), nullable=True),
        sa.Column(
            "media_urls",
            sa.dialects.postgresql.JSONB(astext_type=sa.Text()),
            nullable=False,
            server_default=sa.text("'[]'::jsonb"),
        ),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.CheckConstraint("rating >= 1 AND rating <= 5", name="ck_reviews_rating_1_5"),
        sa.ForeignKeyConstraint(["author_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["post_id"], ["posts.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(op.f("ix_reviews_author_id"), "reviews", ["author_id"], unique=False)
    op.create_index(op.f("ix_reviews_post_id"), "reviews", ["post_id"], unique=False)

    op.create_table(
        "friend_requests",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("requester_id", sa.Integer(), nullable=False),
        sa.Column("receiver_id", sa.Integer(), nullable=False),
        sa.Column(
            "status",
            friend_request_status_enum,
            nullable=False,
            server_default=sa.text("'pending'"),
        ),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.text("now()"), nullable=False),
        sa.ForeignKeyConstraint(["receiver_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["requester_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("requester_id", "receiver_id", name="uq_friend_request_pair"),
    )
    op.create_index(op.f("ix_friend_requests_requester_id"), "friend_requests", ["requester_id"], unique=False)
    op.create_index(op.f("ix_friend_requests_receiver_id"), "friend_requests", ["receiver_id"], unique=False)

    op.create_table(
        "user_achievements",
        sa.Column("user_id", sa.Integer(), nullable=False),
        sa.Column("achievement_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["achievement_id"], ["achievements.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("user_id", "achievement_id"),
    )

    op.create_table(
        "user_interests",
        sa.Column("user_id", sa.Integer(), nullable=False),
        sa.Column("interest_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["interest_id"], ["interests.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("user_id", "interest_id"),
    )

    op.create_table(
        "post_interests",
        sa.Column("post_id", sa.Integer(), nullable=False),
        sa.Column("interest_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["interest_id"], ["interests.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["post_id"], ["posts.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("post_id", "interest_id"),
    )

    op.create_table(
        "user_friends",
        sa.Column("user_id", sa.Integer(), nullable=False),
        sa.Column("friend_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["friend_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("user_id", "friend_id"),
        sa.UniqueConstraint("user_id", "friend_id", name="uq_user_friend_pair"),
    )


def downgrade() -> None:
    op.drop_table("user_friends")
    op.drop_table("post_interests")
    op.drop_table("user_interests")
    op.drop_table("user_achievements")

    op.drop_index(op.f("ix_friend_requests_receiver_id"), table_name="friend_requests")
    op.drop_index(op.f("ix_friend_requests_requester_id"), table_name="friend_requests")
    op.drop_table("friend_requests")

    op.drop_index(op.f("ix_reviews_post_id"), table_name="reviews")
    op.drop_index(op.f("ix_reviews_author_id"), table_name="reviews")
    op.drop_table("reviews")

    op.drop_index(op.f("ix_posts_author_id"), table_name="posts")
    op.drop_table("posts")

    op.drop_index(op.f("ix_interests_name"), table_name="interests")
    op.drop_table("interests")
    op.drop_table("achievements")

    op.drop_index(op.f("ix_users_phone"), table_name="users")
    op.drop_table("users")

    friend_request_status_enum = sa.Enum(
        "pending",
        "accepted",
        "rejected",
        name="friend_request_status_enum",
    )
    season_enum = sa.Enum("spring", "summer", "autumn", "winter", name="season_enum")
    friend_request_status_enum.drop(op.get_bind(), checkfirst=True)
    season_enum.drop(op.get_bind(), checkfirst=True)
