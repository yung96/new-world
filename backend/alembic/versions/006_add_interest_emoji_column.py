"""add emoji column to interests

Revision ID: 006
Revises: 005
Create Date: 2026-03-21 03:00:00.000000
"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "006"
down_revision: Union[str, Sequence[str], None] = "005"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Nullable для безопасной миграции существующих данных.
    # После заполнения можно сделать NOT NULL отдельной миграцией.
    op.add_column("interests", sa.Column("emoji", sa.String(), nullable=True))
    op.create_index(op.f("ix_interests_emoji"), "interests", ["emoji"], unique=True)


def downgrade() -> None:
    op.drop_index(op.f("ix_interests_emoji"), table_name="interests")
    op.drop_column("interests", "emoji")

