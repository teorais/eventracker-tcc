// lib/providers/events_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_app/models/event.dart';

part 'events_provider.g.dart';

// Use a anotação @riverpod para um FutureProvider simples
@riverpod
Future<List<Event>> events(Ref ref) async {
  final url = Uri.parse('http://10.0.2.2:8000/events');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os eventos.');
    }
  } catch (e) {
    // É uma boa prática re-lançar o erro para o .when() poder capturá-lo
    rethrow;
  }
}
