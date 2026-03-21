from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text, func
from sqlalchemy.orm import relationship

from app.models import Base
from app.models.associations import user_achievements


class Achievement(Base):
    __tablename__ = "achievements"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False, unique=True)
    description = Column(Text, nullable=True)
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())
    interest_id = Column(
        Integer, ForeignKey("interests.id", ondelete="RESTRICT"), nullable=True, index=True
    )
    required_distinct_posts = Column(Integer, nullable=True)

    interest = relationship("Interest", back_populates="achievements")
    users = relationship("User", secondary=user_achievements, back_populates="achievements")
