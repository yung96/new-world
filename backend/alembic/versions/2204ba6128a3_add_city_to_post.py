"""add_city_to_post

Revision ID: 2204ba6128a3
Revises: 007
Create Date: 2026-03-21 16:36:19.585772

"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = "2204ba6128a3"
down_revision: Union[str, Sequence[str], None] = "007"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column("posts", sa.Column("city", sa.String(), nullable=True))


def downgrade() -> None:
    op.drop_column("posts", "city")
