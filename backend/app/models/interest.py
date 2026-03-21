from sqlalchemy import Column, DateTime, Integer, String, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import post_interests, user_interests


class Interest(Base):
    __tablename__ = "interests"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False, unique=True, index=True)
    emoji = Column(String, nullable=False, index=True)

    users = relationship("User", secondary=user_interests, back_populates="interests")
    posts = relationship("Post", secondary=post_interests, back_populates="interests")
    achievements = relationship("Achievement", back_populates="interest")
