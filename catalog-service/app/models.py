from sqlalchemy import Column, Integer, String, Float
from .database import Base

class Service(Base):
    __tablename__ = "academy_services"

    id = Column(Integer, primary_key=True, index=True)
    category = Column(String, index=True)  # Facials, Waxing, Makeup, etc.
    name = Column(String, unique=True, index=True)  # Gold Facial, Bridal Makeup, etc.
    price = Column(Float, default=0.0)
    description = Column(String, nullable=True)
    target_audience = Column(String, default="Ladies Only")