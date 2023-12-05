import 'dart:io';
import 'package:flutter/material.dart';
import 'package:signalscan/models/api_response_model.dart';

class ScanDetailsPage extends StatelessWidget {
  final File imageFile;
  final ApiResponse apiResponse;

  const ScanDetailsPage(this.imageFile, this.apiResponse, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Verificar si la lista de predicciones está vacía
    if (apiResponse.predictions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 165, 36, 36),
          title: const Text('Detalles del Escaneo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.85,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: const Text(
                  'No se han encontrado señales de tráfico en la imagen proporcionada.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Almacena los valores de las predicciones en una lista
    List<PredictionValues> predictionsValuesList = [];
    for (var i = 0; i < apiResponse.predictions.length; i++) {
      var prediction = apiResponse.predictions[i];
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
      double desiredImageHeight =
          originalImageHeight * (desiredImageWidth / originalImageWidth);

      // Factor de escala para ajustar el cuadrado al tamaño de la imagen
      double scale = desiredImageWidth / originalImageWidth;

      // Ajusta las coordenadas x e y proporcionalmente
      x = scale * (x - (prediction.width / 2));
      y = scale * (y - (prediction.height / 2)) +
          (MediaQuery.of(context).size.width * 0.85 - desiredImageHeight) / 2;

      // Ajusta el tamaño del cuadrado proporcionalmente
      double width = prediction.width * scale;
      double height = prediction.height * scale;

      predictionsValuesList.add(PredictionValues(
        x: x,
        y: y,
        confidence: confidence,
        className: className,
        width: width,
        height: height,
        number: i + 1, // Número de la predicción
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 36, 36),
        title: const Text('Detalles del Escaneo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.85,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.file(
                      imageFile,
                      height: MediaQuery.of(context).size.width * 0.85,
                      width: MediaQuery.of(context).size.width * 0.85,
                      fit: BoxFit.contain,
                    ),
                    // Dibuja los cuadrados encima de la imagen para cada predicción
                    for (var values in predictionsValuesList)
                      Positioned(
                        left: values.x,
                        top: values.y,
                        child: Column(
                          children: [
                            Container(
                              width: values.width,
                              height: values.height,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: getColorForConfidence(values.confidence),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Text(
                                values.number.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Muestra la información de cada predicción
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (PredictionValues values in predictionsValuesList)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Número: ${values.number}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          Text(
                            'Nombre de la clase: ${values.className}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Confianza: ${(values.confidence * 100).toStringAsFixed(2)}%',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColorForConfidence(double confidence) {
    if (confidence > 0.9) {
      return Colors.green;
    } else if (confidence >= 0.7 && confidence <= 0.9) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
