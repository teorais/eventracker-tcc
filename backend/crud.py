from sqlalchemy.orm import Session
from . import models, schemas, security

def get_user_by_cpf(db: Session, cpf: str) -> models.Usuario | None:
    return db.query(models.Usuario).filter(models.Usuario.cpf == cpf).first()

def create_user(db: Session, user: schemas.UserCreate) -> models.Usuario:
    hashed_password = security.get_password_hash(user.senha)
    db_user = models.Usuario(cpf=user.cpf, nome=user.nome, senha_hash=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user