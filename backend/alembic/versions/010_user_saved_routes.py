"""user saved routes (chain of posts)

Revision ID: 010
Revises: 009
Create Date: 2026-03-21 18:00:00.000000
"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

revision: str = "010"
down_revision: Union[str, Sequence[str], None] = "009"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        "user_saved_routes",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("user_id", sa.Integer(), nullable=False),
        sa.Column("title", sa.String(), nullable=True),
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
        sa.ForeignKeyConstraint(["user_id"], ["users.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
    )
    op.create_index(op.f("ix_user_saved_routes_user_id"), "user_saved_routes", ["user_id"], unique=False)

    op.create_table(
        "user_saved_route_items",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("route_id", sa.Integer(), nullable=False),
        sa.Column("post_id", sa.Integer(), nullable=False),
        sa.Column("position", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["post_id"], ["posts.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["route_id"], ["user_saved_routes.id"], ondelete="CASCADE"),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("route_id", "position", name="uq_user_saved_route_position"),
        sa.UniqueConstraint("route_id", "post_id", name="uq_user_saved_route_post"),
    )
    op.create_index(
        op.f("ix_user_saved_route_items_route_id"), "user_saved_route_items", ["route_id"], unique=False
    )
    op.create_index(
        op.f("ix_user_saved_route_items_post_id"), "user_saved_route_items", ["post_id"], unique=False
    )


def downgrade() -> None:
    op.drop_index(op.f("ix_user_saved_route_items_post_id"), table_name="user_saved_route_items")
    op.drop_index(op.f("ix_user_saved_route_items_route_id"), table_name="user_saved_route_items")
    op.drop_table("user_saved_route_items")
    op.drop_index(op.f("ix_user_saved_routes_user_id"), table_name="user_saved_routes")
    op.drop_table("user_saved_routes")
