from sqlalchemy import Column, Integer, String, DateTime, Float
from sqlalchemy.ext.declarative import declarative_base
import datetime

Base = declarative_base()

class Booking(Base):
    __tablename__ = "service_bookings"

    id = Column(Integer, primary_key=True, index=True)
    customer_name = Column(String)
    service_id = Column(Integer)  # Catalog service nundi vacche ID
    service_name = Column(String)
    appointment_time = Column(DateTime, default=datetime.datetime.utcnow)
    address = Column(String)
    status = Column(String, default="Pending") # Pending, Confirmed, Completed, Cancelled