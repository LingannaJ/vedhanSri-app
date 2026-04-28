from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
import httpx  # Internal Microservice communication kosam
from . import models
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Database Setup
DATABASE_URL = "postgresql://user:password@booking-db:5432/booking_db"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="Vedhan Sri - Booking Service")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Inter-service Communication: Catalog Service nundi service details check cheయడం
CATALOG_SERVICE_URL = "http://catalog-service:8000/services"

@app.post("/book")
async def create_booking(customer_name: str, service_id: int, address: str, db: Session = Depends(get_db)):
    # 1. Catalog service ki request pampi service verify cheyali
    # Real-time troubleshooting lo idi important step
    async with httpx.AsyncClient() as client:
        response = await client.get(f"{CATALOG_SERVICE_URL}")
        # Logic: Check if service_id exists in catalog (Simplified for now)
    
    new_booking = models.Booking(
        customer_name=customer_name,
        service_id=service_id,
        address=address,
        status="Confirmed"
    )
    db.add(new_booking)
    db.commit()
    db.refresh(new_booking)
    return {"message": "Booking Successful", "booking_details": new_booking}

@app.get("/my-bookings/{customer_name}")
def get_user_bookings(customer_name: str, db: Session = Depends(get_db)):
    return db.query(models.Booking).filter(models.Booking.customer_name == customer_name).all()