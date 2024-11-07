import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/auth_response.dart';

class AuthService {
  final String _baseUrl =
      'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test/oauth/token';

  Future<AuthResponse?> authenticate(String email, String password) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String body = json.encode({"email": email, "password": password});

    try {
      Response response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        // Convertimos la respuesta en un AuthResponse
        return AuthResponse.fromJson(json.decode(response.body));
      } else {
        log('Error de autenticación: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      log('Error en la solicitud: $e');
      return null;
    }
  }
}
