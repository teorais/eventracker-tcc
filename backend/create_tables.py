from database import engine, Base
import models

print("Criando tabelas no banco de dados...")

Base.metadata.create_all(bind=engine)

print("Tabelas criadas com sucesso.")