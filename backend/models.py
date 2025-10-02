from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .database import Base

class Usuario(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    cpf = Column(String, unique=True, index=True)
    nome = Column(String)
    senha_hash = Column(String)
    
    # ingressos = relationship("Ingresso", back_populates="comprador")

class Evento(Base):
    __tablename__ = "eventos"

    id = Column(Integer, primary_key=True, index=True)
    nome = Column(String)
    cidade = Column(String)
    data = Column(String)
    tipo = Column(String)
    capacidade = Column(Integer)
    ingressos_vendidos = Column(Integer, default=0)

    # ingressos = relationship("Ingresso", back_populates="evento")

class Ingresso(Base):
    __tablename__ = "ingressos"

    id = Column(Integer, primary_key=True, index=True)
    id_evento = Column(Integer, ForeignKey("eventos.id"))
    id_usuario = Column(Integer, ForeignKey("usuarios.id"))

    # evento = relationship("Evento", back_populates="ingressos")
    # comprador = relationship("Usuario", back_populates="ingressos")