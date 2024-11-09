import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/client_model.dart';

class ClientsService {
  final String baseUrl =
      'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test';

  Future<List<Client>> fetchClients(String token) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    final http.Response response = await http.get(
      Uri.parse('$baseUrl/clients'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      List data = responseBody['data'];

      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  // Método para agregar un nuevo cliente
  Future<bool?> addClient({
    required String token,
    required String firstName,
    required String lastName,
    required String email,
    String? photo,
  }) async {
    final Uri url = Uri.parse('$baseUrl/clients');

    // Headers con el token de autorización
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    // Cuerpo de la solicitud en formato JSON
    final String body = jsonEncode({
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "address": "",
      "photo": photo ?? "",
      "caption": "",
    });

    // Realiza la petición POST
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // Verifica si la petición fue exitosa
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add client');
    }
  }
}
