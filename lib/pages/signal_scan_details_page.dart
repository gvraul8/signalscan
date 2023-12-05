import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signalscan/models/api_response_model.dart';

class ScanDetailsPage extends StatelessWidget {
  final File imageFile;
  final ApiResponse apiResponse;

  const ScanDetailsPage(this.imageFile, this.apiResponse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Prediction prediction = apiResponse.predictions.isNotEmpty
        ? apiResponse.predictions[0]
        : Prediction(x: 0, y: 0, width: 0, height: 0, confidence: 0, classLabel: "", classId: 0);

    double x = prediction.x;
    double y = prediction.y;
    double confidence = prediction.confidence;
    String className = prediction.classLabel;

    // Dimensiones reales de la imagen
    double originalImageWidth = apiResponse.image.width.toDouble();
    double originalImageHeight = apiResponse.image.height.toDouble();

    // Ancho deseado de la imagen (ajustado al ancho de la pantalla)
    double desiredImageWidth = MediaQuery.of(context).size.width * 0.85;

    // Calcular la altura para mantener la relación de aspecto
    double desiredImageHeight = originalImageHeight * (desiredImageWidth / originalImageWidth);

    // Factor de escala para ajustar el cuadrado al tamaño de la imagen
    double scale = desiredImageWidth / originalImageWidth;

    // Ajusta las coordenadas x e y proporcionalmente
    x = scale * (x - (prediction.width / 2));
    y = scale * (y - (prediction.height / 2));

    // Ajusta el tamaño del cuadrado proporcionalmente
    double width = prediction.width * scale;
    double height = prediction.height * scale;

    Color cuadradoColor = Colors.red; // Rojo por defecto
    if (confidence > 0.9) {
      cuadradoColor = Colors.green;
    } else if (confidence >= 0.7 && confidence <= 0.9) {
      cuadradoColor = Colors.yellow;
    }

    // Adjust the position of the text based on the scaling factor
    double scaledTextTopMargin = 10.0 * scale;
    double scaledTextBottomMargin = 10.0 * scale;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Escaneo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Muestra la imagen ajustada
            Container(
              margin: EdgeInsets.only(top: scaledTextTopMargin),
              width: desiredImageWidth,
              height: desiredImageHeight,
              child: Stack(
                children: [
                  // Coloca la imagen utilizando Image.file
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Image.file(
                      imageFile,
                      height: desiredImageHeight,
                      width: desiredImageWidth,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Coloca el cuadrado encima de la imagen
                  Positioned(
                    left: x,
                    top: y,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cuadradoColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Muestra el nombre de la clase y el porcentaje de confianza
            Container(
              margin: EdgeInsets.only(top: scaledTextTopMargin, bottom: scaledTextBottomMargin),
              child: Column(
                children: [
                  Text('Nombre de la clase: $className'),
                  Text('Confianza: ${(confidence * 100).toStringAsFixed(2)}%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}