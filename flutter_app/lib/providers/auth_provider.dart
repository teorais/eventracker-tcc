import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

class AuthState {
  final String? token;
  final bool isAuthenticated;

  AuthState({this.token, this.isAuthenticated = false});
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Future<AuthState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return AuthState(isAuthenticated: false);
    }

    return AuthState(token: token, isAuthenticated: true);
  }

  Future<void> login(String cpf, String senha) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/token');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': cpf, 'password': senha},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        state = AsyncData(AuthState(token: token, isAuthenticated: true));
      } else {
        throw Exception('CPF ou senha inválidos.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    state = AsyncData(AuthState(isAuthenticated: false));
  }
}
