from fastapi import FastAPI

# Cria uma instância da aplicação FastAPI
app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Olá! Bem-vindo à API do App de Ingressos!"}

# Dados mockados (simulando um banco de dados)
db_eventos = [
    {"id": 1, "nome": "Show de Rock", "cidade": "Goiânia", "data": "2025-09-28"},
    {"id": 2, "nome": "Peça de Teatro", "cidade": "Anápolis", "data": "2025-10-15"},
    {"id": 3, "nome": "Jogo de Futebol", "cidade": "Goiânia", "data": "2025-09-30"},
]

# Endpoint para listar todos os eventos
@app.get("/eventos")
def listar_eventos():
    return db_eventos

# Endpoint para buscar um evento por ID
# O {id} na URL é um "path parameter". O FastAPI o passa para a função.
# O "id: int" é um Type Hint que valida que o id deve ser um inteiro.
@app.get("/eventos/{id}")
def buscar_evento_por_id(id: int):
    for evento in db_eventos:
        if evento["id"] == id:
            return evento
    return {"message": "Evento não encontrado"}
