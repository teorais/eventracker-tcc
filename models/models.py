class Usuario:
    
    def __init__(self, cpf, nome):
        self.nome = nome
        self.cpf = cpf
        self.ingressos_comprados = []

class Evento:
    
    def __init__(self, nome, cidade, data, tipo, capacidade):
        self.nome = nome
        self.cidade = cidade
        self.data = data
        self.tipo = tipo
        self.capacidade = capacidade
        self.ingressos_disponiveis = 0
    
    def exibir_detalhes(self):
        print(f"Nome: {self.nome}")
        print(f"Cidade: {self.cidade}")
        print(f"Data: {self.data}")
        print(f"Tipo: {self.tipo}")
        print(f"Capacidade: {self.capacidade}")
        print(f"Vendidos: {self.ingressos_disponiveis} de {self.capacidade}")