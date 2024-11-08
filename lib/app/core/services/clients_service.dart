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
      //TODO
      return data.map((client) => Client.fromJson(client)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }
}
