class Event {
  final int id;
  final String nome;
  final String cidade;
  final String data;
  final double preco;

  Event({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.data,
    required this.preco,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      nome: json['nome'],
      cidade: json['cidade'],
      data: json['data'],
      preco: double.parse(json['preco'].toString()),
    );
  }
}
