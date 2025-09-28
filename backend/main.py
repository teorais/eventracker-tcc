# main criado apenas a critério de testes para validação dos estudos
from models import Usuario, Evento, Ingresso

print("CRIANDO USUÁRIOS E EVENTOS...")
usuario1 = Usuario(cpf="111.222.333-44", nome="João da Silva")
evento_show = Evento(nome="Show de Rock", cidade="Goiânia", data="28/09/2025", tipo="Show", capacidade=100)

print("\nEXIBINDO DETALHES INICIAIS...")
usuario1.mostrar_infos()
evento_show.exibir_detalhes()

print("\nVENDENDO INGRESSOS...")
evento_show.vender_ingressos(1)

print("\nCRIANDO O OBJETO INGRESSO...")
ingresso_joao = Ingresso(evento=evento_show, usuario=usuario1)

usuario1.ingressos_comprados.append(ingresso_joao)

print("\nEXIBINDO INFORMAÇÕES FINAIS...")
ingresso_joao.exibir_resumo()

print(f"\nO usuário {usuario1.nome} tem {len(usuario1.ingressos_comprados)} ingresso(s).")
evento_show.exibir_detalhes()