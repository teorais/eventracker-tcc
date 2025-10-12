import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Inicial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: const Center(child: Text('Você está logado!')),
    );
  }
}
