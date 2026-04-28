from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from . import models, database
import logging

# Create tables in DB
models.Base.metadata.create_all(bind=database.engine)

app = FastAPI(title="Vedhan Sri Beauty Academy - Catalog Service")
logger = logging.getLogger(__name__)

@app.get("/services", response_model=list)
def read_services(db: Session = Depends(database.get_db)):
    services = db.query(models.Service).all()
    return services

@app.post("/services/add")
def create_service(category: str, name: str, price: float, db: Session = Depends(database.get_db)):
    db_service = models.Service(category=category, name=name, price=price)
    db.add(db_service)
    db.commit()
    db.refresh(db_service)
    logger.info(f"New service added: {name}")
    return db_service

@app.get("/health")
def health():
    return {"status": "up and running"}