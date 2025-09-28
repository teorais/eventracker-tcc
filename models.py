class Usuario:
    
    def __init__(self, cpf, nome):
        self.nome = nome
        self.cpf = cpf
        self.ingressos_comprados = []
        
    def mostrar_infos(self):
        print(f"Nome: {self.nome}")
        print(f"CPF: {self.cpf}")
        
###############################################################################

class Evento:
    
    def __init__(self, nome, cidade, data, tipo, capacidade):
        self.nome = nome
        self.cidade = cidade
        self.data = data
        self.tipo = tipo
        self.capacidade = capacidade
        self.ingressos_vendidos = 0
    
    def exibir_detalhes(self):
        print(f"Nome: {self.nome}")
        print(f"Cidade: {self.cidade}")
        print(f"Data: {self.data}")
        print(f"Tipo: {self.tipo}")
        print(f"Capacidade: {self.capacidade}")
        print(f"Vendidos: {self.ingressos_vendidos} de {self.capacidade}")
        
    def vender_ingressos(self, quantidade):
        if(self.ingressos_vendidos + quantidade > self.capacidade):
            print(f"A quantidade de ingressos desejada excede a capacidade máxima do evento. \nIngressos disponíveis: {self.capacidade - self.ingressos_vendidos}")
        else:
            self.ingressos_vendidos += quantidade
            print(f"{quantidade} ingresso(s) vendido(s) para o evento {self.nome}.")
            
    def verificar_disponibilidade(self):
        return self.ingressos_vendidos < self.capacidade
        
###############################################################################
        
class Ingresso:
    
    def __init__(self, evento: Evento, usuario: Usuario):
        self.evento = evento
        self.usuario = usuario
        
    def exibir_resumo(self):
        print("--- Resumo do Ingresso ---")
        print(f"Evento: {self.evento.nome} ({self.evento.data})")
        print(f"Comprador: {self.usuario.nome} (CPF: {self.usuario.cpf})")