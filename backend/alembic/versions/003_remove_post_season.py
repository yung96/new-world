"""remove season from posts

Revision ID: 003
Revises: 002
Create Date: 2026-03-21 00:00:00.000000
"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "003"
down_revision: Union[str, Sequence[str], None] = "002"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.drop_column("posts", "season")
    op.execute("DROP TYPE IF EXISTS season_enum")


def downgrade() -> None:
    season_enum = sa.Enum("spring", "summer", "autumn", "winter", name="season_enum")
    season_enum.create(op.get_bind(), checkfirst=True)
    op.add_column(
        "posts",
        sa.Column("season", season_enum, nullable=False, server_default=sa.text("'summer'")),
    )
    op.alter_column("posts", "season", server_default=None)

