import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

class DetailsPage extends StatelessWidget {
  final String apiResponse;
  final File imageFile;

  const DetailsPage({
    required this.apiResponse,
    required this.imageFile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Procesar la respuesta de la API
    Map<String, dynamic> responseJson = jsonDecode(apiResponse);

    // Obtener las predicciones
    List<dynamic> predictions = responseJson['predictions'];

    // Verificar si hay predicciones
    if (predictions.isNotEmpty) {
      // Tomar solo la primera predicción (puedes ajustar según tus necesidades)
      Map<String, dynamic> prediction = predictions[0];

      // Obtener la información de la predicción
      double x = prediction['x'].toDouble();
      double y = prediction['y'].toDouble();
      double width = prediction['width'].toDouble();
      double height = prediction['height'].toDouble();
      double confidence = prediction['confidence'].toDouble();
      String className = prediction['class'];
      int classId = prediction['class_id'];

      // Construir la descripción
      String description = "Class: $className\n"
          "Confidence: $confidence\n"
          "Class ID: $classId";

      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ImageWithBoundingBox(imageFile, x, y, width, height),
                  const SizedBox(height: 16.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles'),
        ),
        body: Center(
          child: Text(
            'No se encontraron predicciones.',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    }
  }
}

class ImageWithBoundingBox extends StatelessWidget {
  final File imageFile;
  final double x, y, width, height;

  ImageWithBoundingBox(
    this.imageFile,
    this.x,
    this.y,
    this.width,
    this.height,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2.0),
      ),
      child: Image.file(
        imageFile,
        fit: BoxFit.contain,
      ),
      margin: EdgeInsets.all(8.0),
    );
  }
}
