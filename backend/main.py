from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session


import models
from database import SessionLocal, engine

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/eventos")
def listar_eventos(db: Session = Depends(get_db)):
    eventos = db.query(models.Evento).all()
    return eventos