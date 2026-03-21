from sqlalchemy import Boolean, Column, DateTime, Float, ForeignKey, Integer, String, UniqueConstraint, func
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import relationship

from app.models import Base


class UserSavedRoute(Base):
    """Маршрут: точка А (гео, не пост) + упорядоченная цепочка постов (мест)."""

    __tablename__ = "user_saved_routes"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, index=True)
    title = Column(String, nullable=True)
    start_lat = Column(Float, nullable=False)
    start_lng = Column(Float, nullable=False)
    start_label = Column(String, nullable=True)
    ai_generated = Column(Boolean, nullable=False, default=False, server_default="false")
    ai_route_meta = Column(JSONB, nullable=True)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())
    updated_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now(), onupdate=func.now())

    user = relationship("User", back_populates="saved_routes")
    items = relationship(
        "UserSavedRouteItem",
        back_populates="route",
        order_by="UserSavedRouteItem.position",
        cascade="all, delete-orphan",
    )


class UserSavedRouteItem(Base):
    __tablename__ = "user_saved_route_items"

    id = Column(Integer, primary_key=True, autoincrement=True)
    route_id = Column(
        Integer, ForeignKey("user_saved_routes.id", ondelete="CASCADE"), nullable=False, index=True
    )
    post_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), nullable=False, index=True)
    position = Column(Integer, nullable=False)

    route = relationship("UserSavedRoute", back_populates="items")
    post = relationship("Post")

    __table_args__ = (
        UniqueConstraint("route_id", "position", name="uq_user_saved_route_position"),
        UniqueConstraint("route_id", "post_id", name="uq_user_saved_route_post"),
    )
