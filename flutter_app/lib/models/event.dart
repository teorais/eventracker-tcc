class Event {
  final int id;
  final String nome;
  final String cidade;
  final String data;
  final String tipo;
  final double preco;
  final int capacidade;

  Event({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.data,
    required this.tipo,
    required this.preco,
    required this.capacidade,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      nome: json['nome'],
      cidade: json['cidade'],
      data: json['data'],
      tipo: json['tipo'],
      preco: double.parse(json['preco'].toString()),
      capacidade: json['capacidade'] as int,
    );
  }
}
