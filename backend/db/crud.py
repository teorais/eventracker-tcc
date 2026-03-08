from sqlalchemy.orm import Session

from backend.core import security
from backend.db import models, schemas

def get_user_by_cpf(db: Session, cpf: str) -> models.Usuario | None:
    return db.query(models.Usuario).filter(models.Usuario.cpf == cpf).first()

def create_user(db: Session, user: schemas.UserCreate) -> models.Usuario:
    hashed_password = security.get_password_hash(user.senha)
    db_user = models.Usuario(cpf=user.cpf, nome=user.nome, senha_hash=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_events(db: Session) -> list[models.Evento]:
    return db.query(models.Evento).all()

def create_event(db: Session, event: schemas.EventCreate) -> models.Evento:
    # linha equivalente a: db_event = models.Evento(nome=event.nome, cidade=event.cidade, data=event.data, tipo=event.tipo, capacidade=event.capacidade, preco=event.preco, ingressos_vendidos=0)
    db_event = models.Evento(**event.model_dump(), ingressos_vendidos=0)
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event