import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:signalscan/models/api_response_model.dart';

const String apiUrl = "https://detect.roboflow.com/ts-v5/1";
const String apiKey = "ftKgIkOFKpkA8w6AP6Tt";

class ApiService {
  static Future<ApiResponse> sendImageForDetection(File imageFile) async {
    // Lee los bytes del archivo
    List<int> imageBytes = await imageFile.readAsBytes();

    // Convierte los bytes a base64
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse("$apiUrl?api_key=$apiKey"),
      body: base64Image,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, analiza la respuesta JSON
      Map<String, dynamic> responseData = json.decode(response.body);
      return ApiResponse.fromJson(responseData);
    } else {
      // Si la solicitud no fue exitosa, lanza una excepción.
      throw Exception('Error al cargar datos desde la API');
    }
  }
}
