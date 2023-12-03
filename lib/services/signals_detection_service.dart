import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> sendImageForDetection(File imageFile) async {
    var url = 'https://universe.roboflow.com/tsr/traffic-sign-detection-reixh/model/3';
    var apiKey = 'tekmwH2Ki0bs1UWe3aT7'; // Reemplaza con tu clave de API

    try {
      // Leer el contenido del archivo de imagen
      List<int> imageBytes = await imageFile.readAsBytes();

      // Codificar la imagen en base64
      String base64Image = base64Encode(imageBytes);

      // Crear el cuerpo de la solicitud
      var requestBody = {'image': base64Image};

      // Realizar la solicitud HTTP POST
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Return the response as a String
        return response.body;
      } else {
        // Handle the error case
        throw Exception('Error in API request: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network or other errors
      throw Exception('Error in API request: $e');
    }
  }
}
