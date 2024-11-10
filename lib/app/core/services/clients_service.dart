import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/client_model.dart';

enum ClientMethod {
  update('/2'),
  create('');

  final String endpoint;

  const ClientMethod(this.endpoint);
}

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
  Future<bool?> requestServer({
    required String token,
    required String firstName,
    required String lastName,
    required String email,
    required ClientMethod clientMethod,
    String? photo,
  }) async {
    final String endpoint = clientMethod.endpoint;

    final Uri url = Uri.parse('$baseUrl/clients$endpoint');

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

  Future<bool?> deleteClient(String token, String id) async {
    // Configuración de la URL y los encabezados
    final String url =
        'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test/clients/$id';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      // Realizamos la solicitud POST para eliminar el cliente
      final http.Request request = http.Request(
        "DELETE",
        Uri.parse(url),
        // headers: headers,
      );

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      // Manejo de la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        String responseBody = await response.stream.bytesToString();

        log('Cliente eliminado exitosamente: $responseBody');
      } else {
        log('Error al eliminar el cliente: ${response.reasonPhrase}');
        throw Exception('Failed to delete client');
      }
    } catch (e) {
      // Manejo de excepciones
      log('Excepción al intentar eliminar el cliente: $e');
      throw Exception('Failed to delete client');
    }
    return null;
  }
}
