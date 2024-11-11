import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/client_model.dart';

enum ClientMethod {
  update('PUT', '/clients'),
  create('POST', '/clients'),
  delete('DELETE', '/clients');

  final String method;
  final String endpoint;
  const ClientMethod(this.method, this.endpoint);
}

class ClientsService {
  final String baseUrl =
      'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test';

  Future<List<Client>> fetchClients(String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    final response = await http.get(
      Uri.parse('$baseUrl/clients'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final List data = responseBody['data'];
      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }

  Future<bool?> requestServer({
    required String token,
    String? firstName,
    String? lastName,
    String? email,
    required ClientMethod clientMethod,
    String? id,
    String? photo,
  }) async {
    final url = Uri.parse(
        '$baseUrl${clientMethod.endpoint}${id != null ? '/$id' : ''}');
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      "firstname": firstName ?? "",
      "lastname": lastName ?? "",
      "email": email ?? "",
      "address": "",
      "photo": photo ?? "",
      "caption": "",
    });

    return await sendRequest(
      url: url,
      headers: headers,
      method: clientMethod.method,
      body: body,
    );
  }

  Future<bool?> sendRequest({
    required Uri url,
    required Map<String, String> headers,
    required String method,
    String? body,
  }) async {
    try {
      http.Request request = http.Request(method, url);
      request.headers.addAll(headers);
      if (body != null) {
        request.body = body;
      }

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Request successful: ${await response.stream.bytesToString()}');
        return true;
      } else {
        log('Error in request: ${response.reasonPhrase}');
        throw Exception('Request failed');
      }
    } catch (e) {
      log('Exception in request: $e');
      throw Exception('Failed to complete request');
    }
  }

  Future<bool?> deleteClient(String token, String id) async {
    return await sendRequest(
      url: Uri.parse('$baseUrl/clients/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      method: ClientMethod.delete.method,
    );
  }

  Future<bool?> updateClient({
    required String token,
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? photo,
  }) async {
    return await requestServer(
      token: token,
      firstName: firstName,
      lastName: lastName,
      email: email,
      clientMethod: ClientMethod.update,
      id: id,
      photo: photo,
    );
  }
}
