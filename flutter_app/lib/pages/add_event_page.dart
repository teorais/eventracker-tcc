import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _dataController = TextEditingController();
  final _tipoController = TextEditingController(); // Novo campo
  final _precoController = TextEditingController();
  final _capacidadeController = TextEditingController(); // Novo campo

  @override
  void dispose() {
    _nomeController.dispose();
    _cidadeController.dispose();
    _dataController.dispose();
    _tipoController.dispose();
    _precoController.dispose();
    _capacidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Novo Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Evento',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe o nome'
                              : null,
                ),
                TextFormField(
                  controller: _cidadeController,
                  decoration: const InputDecoration(labelText: 'Cidade'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe a cidade'
                              : null,
                ),
                TextFormField(
                  controller: _dataController,
                  decoration: const InputDecoration(
                    labelText: 'Data (Ex: 12/12/2025)',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe a data'
                              : null,
                ),
                TextFormField(
                  controller: _tipoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo (Ex: Show, Workshop)',
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe o tipo'
                              : null,
                ),
                TextFormField(
                  controller: _precoController,
                  decoration: const InputDecoration(labelText: 'Preço'),
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe o preço'
                              : null,
                ),
                TextFormField(
                  controller: _capacidadeController,
                  decoration: const InputDecoration(
                    labelText: 'Capacidade Total',
                  ),
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Informe a capacidade'
                              : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Lógica de salvamento será implementada a seguir
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Salvar Evento'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
