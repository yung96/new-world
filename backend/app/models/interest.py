from sqlalchemy import Column, DateTime, Integer, String, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import post_interests, user_interests


class Interest(Base):
    __tablename__ = "interests"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False, unique=True, index=True)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    users = relationship("User", secondary=user_interests, back_populates="interests")
    posts = relationship("Post", secondary=post_interests, back_populates="interests")
