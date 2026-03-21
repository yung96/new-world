"""merge_heads

Revision ID: 74da7452b067
Revises: 009, b844e2c40e7b
Create Date: 2026-03-21 23:27:27.697963

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '74da7452b067'
down_revision: Union[str, Sequence[str], None] = ('009', 'b844e2c40e7b')
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
