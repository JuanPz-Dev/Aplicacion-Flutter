import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

class ApiClient {
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? params,
  }) async {
    final uri = Uri.parse('$_baseUrl$path').replace(queryParameters: {
      'api_key': dotenv.env['API_KEY'] ?? '',
      ...?params,
    });
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      switch (response.statusCode) {
        case 200:
          return json.decode(response.body) as Map<String, dynamic>;
        case 404:
          throw ApiException('Recurso no encontrado');
        default:
          throw ApiException('Error del servidor (${response.statusCode})');
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    }
  }
}