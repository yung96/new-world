"""drop unique index for interest emoji

Revision ID: 007
Revises: 006
Create Date: 2026-03-20 22:10:00.000000
"""

from typing import Sequence, Union

from alembic import op


# revision identifiers, used by Alembic.
revision: str = "007"
down_revision: Union[str, Sequence[str], None] = "006"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.drop_index(op.f("ix_interests_emoji"), table_name="interests")
    op.create_index(op.f("ix_interests_emoji"), "interests", ["emoji"], unique=False)


def downgrade() -> None:
    op.drop_index(op.f("ix_interests_emoji"), table_name="interests")
    op.create_index(op.f("ix_interests_emoji"), "interests", ["emoji"], unique=True)

