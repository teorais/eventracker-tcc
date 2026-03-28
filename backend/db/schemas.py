from pydantic import BaseModel
from decimal import Decimal

class UserCreate(BaseModel):
    cpf: str
    nome: str
    senha: str
    email: str
    telefone: str
    data_nascimento: str
    genero: str

class User(BaseModel):
    id: int
    cpf: str
    nome: str
    email: str
    telefone: str
    data_nascimento: str
    genero: str

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class EventCreate(BaseModel):
    nome: str
    cidade: str
    data: str
    tipo: str
    preco: Decimal
    capacidade: int

class Event(BaseModel):
    id: int
    nome: str
    cidade: str
    data: str
    tipo: str
    preco: Decimal
    capacidade: int
    ingressos_vendidos: int

    class Config:
        from_attributes = True