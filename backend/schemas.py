from pydantic import BaseModel

class UserCreate(BaseModel):
    cpf: str
    nome: str
    senha: str

class User(BaseModel):
    id: int
    cpf: str
    nome: str

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str