"""saved routes: point A as geo, not a post

Revision ID: 011
Revises: 010
Create Date: 2026-03-21 22:00:00.000000
"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

revision: str = "011"
down_revision: Union[str, Sequence[str], None] = "010"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column("user_saved_routes", sa.Column("start_lat", sa.Float(), nullable=True))
    op.add_column("user_saved_routes", sa.Column("start_lng", sa.Float(), nullable=True))
    op.add_column("user_saved_routes", sa.Column("start_label", sa.String(), nullable=True))

    # Старые маршруты: точка А была первым постом — переносим координаты в колонки и убираем первый item.
    op.execute(
        """
        UPDATE user_saved_routes u
        SET
            start_lat = COALESCE(p.geo_lat, 59.9343),
            start_lng = COALESCE(p.geo_lng, 30.3351),
            start_label = LEFT(
                COALESCE(NULLIF(TRIM(CONCAT_WS(' ', p.city, p.title)), ''), 'Старт'),
                500
            )
        FROM user_saved_route_items ui
        JOIN posts p ON p.id = ui.post_id
        WHERE ui.route_id = u.id AND ui."position" = 0
        """
    )
    op.execute(
        """
        UPDATE user_saved_routes
        SET start_lat = 59.9343, start_lng = 30.3351, start_label = 'Старт'
        WHERE start_lat IS NULL
        """
    )
    op.execute('DELETE FROM user_saved_route_items WHERE "position" = 0')
    op.execute(
        """
        WITH ordered AS (
            SELECT id,
                   ROW_NUMBER() OVER (PARTITION BY route_id ORDER BY "position") - 1 AS new_pos
            FROM user_saved_route_items
        )
        UPDATE user_saved_route_items i
        SET "position" = o.new_pos
        FROM ordered o
        WHERE i.id = o.id AND i."position" <> o.new_pos
        """
    )

    op.alter_column("user_saved_routes", "start_lat", existing_type=sa.Float(), nullable=False)
    op.alter_column("user_saved_routes", "start_lng", existing_type=sa.Float(), nullable=False)


def downgrade() -> None:
    op.alter_column("user_saved_routes", "start_lng", existing_type=sa.Float(), nullable=True)
    op.alter_column("user_saved_routes", "start_lat", existing_type=sa.Float(), nullable=True)
    op.drop_column("user_saved_routes", "start_label")
    op.drop_column("user_saved_routes", "start_lng")
    op.drop_column("user_saved_routes", "start_lat")
