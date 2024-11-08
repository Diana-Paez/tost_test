import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/auth_response_model.dart';

class AuthService {
  String? _token; // Token almacenado

  // Método para obtener el token
  String? get token => _token;

  final String _baseUrl =
      'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test/oauth/token';

  Future<AuthResponseModel?> authenticate(String email, String password) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String body = json.encode({"email": email, "password": password});

    try {
      Response response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final AuthResponseModel authResponseModel =
            AuthResponseModel.fromJson(json.decode(response.body));

        _token = authResponseModel.accessToken;
        // Convertimos la respuesta en un AuthResponse
        return authResponseModel;
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
