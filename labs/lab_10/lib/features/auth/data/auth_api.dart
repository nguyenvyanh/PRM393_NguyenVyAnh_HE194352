import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/login_response.dart';

class AuthApi {
  static final Uri _loginUri = Uri.parse('https://dummyjson.com/auth/login');

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      _loginUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(body);
    }

    throw Exception(body['message']?.toString() ?? 'Login failed');
  }
}
