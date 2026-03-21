"""subscriptions replace friends

Revision ID: 008
Revises: 2204ba6128a3
Create Date: 2026-03-21 12:00:00.000000
"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = "008"
down_revision: Union[str, Sequence[str], None] = "2204ba6128a3"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        "user_subscriptions",
        sa.Column("subscriber_id", sa.Integer(), nullable=False),
        sa.Column("following_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["following_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["subscriber_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("subscriber_id", "following_id"),
        sa.CheckConstraint(
            "subscriber_id <> following_id", name="ck_user_subscriptions_no_self"
        ),
    )
    op.create_index(
        op.f("ix_user_subscriptions_subscriber_id"),
        "user_subscriptions",
        ["subscriber_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_user_subscriptions_following_id"),
        "user_subscriptions",
        ["following_id"],
        unique=False,
    )

    op.execute(
        sa.text(
            """
            INSERT INTO user_subscriptions (subscriber_id, following_id)
            SELECT user_id, friend_id FROM user_friends
            WHERE user_id <> friend_id
            ON CONFLICT DO NOTHING
            """
        )
    )

    op.drop_table("user_friends")

    op.drop_index(op.f("ix_friend_requests_receiver_id"), table_name="friend_requests")
    op.drop_index(op.f("ix_friend_requests_requester_id"), table_name="friend_requests")
    op.drop_table("friend_requests")

    op.execute(sa.text("DROP TYPE friend_request_status_enum"))


def downgrade() -> None:
    friend_request_status_enum = postgresql.ENUM(
        "pending",
        "accepted",
        "rejected",
        name="friend_request_status_enum",
        create_type=True,
    )
    friend_request_status_enum.create(op.get_bind(), checkfirst=True)

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
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            server_default=sa.text("now()"),
            nullable=False,
        ),
        sa.ForeignKeyConstraint(["receiver_id"], ["users.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["requester_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint(
            "requester_id", "receiver_id", name="uq_friend_request_pair"
        ),
    )
    op.create_index(
        op.f("ix_friend_requests_requester_id"),
        "friend_requests",
        ["requester_id"],
        unique=False,
    )
    op.create_index(
        op.f("ix_friend_requests_receiver_id"),
        "friend_requests",
        ["receiver_id"],
        unique=False,
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

    op.drop_index(
        op.f("ix_user_subscriptions_following_id"), table_name="user_subscriptions"
    )
    op.drop_index(
        op.f("ix_user_subscriptions_subscriber_id"), table_name="user_subscriptions"
    )
    op.drop_table("user_subscriptions")
