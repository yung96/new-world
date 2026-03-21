from sqlalchemy import BigInteger, Column, DateTime, ForeignKey, Integer, String, Text, func
from sqlalchemy.dialects.postgresql import JSONB

from app.models import Base


class Expert(Base):
    __tablename__ = "experts"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    name = Column(String, nullable=False)
    photo_url = Column(String, nullable=True)
    specialization = Column(String, nullable=True)
    price_from = Column(Integer, nullable=True)
    bio = Column(Text, nullable=True)
    contacts = Column(JSONB, nullable=True)
    region_id = Column(
        BigInteger,
        ForeignKey("geo_regions.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    created_at = Column(DateTime(timezone=True), nullable=False, server_default=func.now())
