import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dkdt8lk9b";
  final String uploadPreset = "test tots";
  final String apiKey = "331151482653717";

  Future<String?> uploadImage(File imageFile) async {
    final Uri url =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final http.MultipartRequest request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['api_key'] = apiKey
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      return jsonResponse['url'];
    } else {
      log("Error uploading image: ${response.statusCode} - ${response.reasonPhrase}");
      return null;
    }
  }
}
