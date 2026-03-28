import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/events_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/pages/add_event_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Eventracker TCC',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: authState.when(
        data:
            (data) =>
                data.isAuthenticated ? const HomePage() : const LoginPage(),
        loading:
            () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error:
            (err, stack) =>
                const Scaffold(body: Center(child: Text("Ocorreu um erro"))),
      ),
    );
  }
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _isLoading = false;
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref
          .read(authProvider.notifier)
          .login(_cpfController.text, _senhaController.text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.login, size: 100, color: Colors.blue),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _cpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        ),
                      )
                      : const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. "Assistimos" ao provedor de eventos.
    // O asyncEvents é do tipo AsyncValue<List<Event>>
    final asyncEvents = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos Disponíveis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Chama o logout do nosso authProvider
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      // 2. O .when() nos obriga a tratar os 3 estados possíveis:
      body: asyncEvents.when(
        // CASO DE SUCESSO: Temos a lista de eventos
        data: (events) {
          if (events.isEmpty) {
            return const Center(child: Text('Nenhum evento cadastrado ainda.'));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.event)),
                  title: Text(
                    event.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${event.cidade} • ${event.data}'),
                  trailing: Text(
                    'R\$ ${event.preco.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Futuramente: Navegar para detalhes do evento
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selecionou: ${event.nome}')),
                    );
                  },
                ),
              );
            },
          );
        },
        // CASO DE ERRO: Algo deu errado na requisição (ex: backend desligado)
        error:
            (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text('Erro ao carregar eventos: $err'),
                  ElevatedButton(
                    onPressed: () => ref.refresh(eventsProvider),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            ),
        // CASO DE CARREGAMENTO: A requisição ainda está em curso
        loading: () => const Center(child: CircularProgressIndicator()),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEventPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
