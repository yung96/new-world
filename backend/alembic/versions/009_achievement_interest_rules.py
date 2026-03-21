"""achievement interest rules and earned_at

Revision ID: 009
Revises: 008
Create Date: 2026-03-21 14:00:00.000000
"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

revision: str = "009"
down_revision: Union[str, Sequence[str], None] = "008"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "achievements",
        sa.Column("interest_id", sa.Integer(), nullable=True),
    )
    op.add_column(
        "achievements",
        sa.Column("required_distinct_posts", sa.Integer(), nullable=True),
    )
    op.create_foreign_key(
        op.f("fk_achievements_interest_id_interests"),
        "achievements",
        "interests",
        ["interest_id"],
        ["id"],
        ondelete="RESTRICT",
    )
    op.create_index(
        op.f("ix_achievements_interest_id"),
        "achievements",
        ["interest_id"],
        unique=False,
    )
    op.create_check_constraint(
        "ck_achievements_required_distinct_posts_positive",
        "achievements",
        "required_distinct_posts IS NULL OR required_distinct_posts >= 1",
    )

    op.add_column(
        "user_achievements",
        sa.Column(
            "earned_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("now()"),
        ),
    )


def downgrade() -> None:
    op.drop_column("user_achievements", "earned_at")
    op.drop_constraint(
        "ck_achievements_required_distinct_posts_positive",
        "achievements",
        type_="check",
    )
    op.drop_index(op.f("ix_achievements_interest_id"), table_name="achievements")
    op.drop_constraint(
        op.f("fk_achievements_interest_id_interests"),
        "achievements",
        type_="foreignkey",
    )
    op.drop_column("achievements", "required_distinct_posts")
    op.drop_column("achievements", "interest_id")
