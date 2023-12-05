import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalscan/models/api_response_model.dart';
import 'package:signalscan/pages/signal_scan_details_page.dart';
import 'package:signalscan/services/signals_detection_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGNALSCAN"),
        backgroundColor: const Color.fromARGB(255, 165, 36, 36),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 175,
            child: Image.asset(
              'assets/signalScanLogo.png',
              height: 200,
              width: 170,
            ),
          ),
          // Buttons in the same row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  getGall();
                },
                color: const Color.fromARGB(255, 165, 36, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Take from gallery",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16), // Agrega espacio entre los botones
              MaterialButton(
                onPressed: () {
                  getCam();
                },
                color: const Color.fromARGB(255, 165, 36, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Take from camera",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // Selected image
          Container(
            width: file == null
                ? 220.0 // Tamaño original deseado cuando no hay imagen seleccionada
                : MediaQuery.of(context).size.width * 0.8, // Multiplicado por 0.8 para dejar un margen
            height: file == null ? 220.0 : null, // Establecer la altura solo cuando no hay imagen seleccionada
            color: file == null ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
            child: file == null
                ? const Icon(
                    Icons.image,
                    size: 50,
                  )
                : AspectRatio(
                    aspectRatio: file!.readAsBytesSync().lengthInBytes.toDouble() /
                        file!.readAsBytesSync().lengthInBytes.toDouble(),
                    child: Image.file(
                      file!,
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
          // Button to view details
          MaterialButton(
            onPressed: () async {
              if (file != null) {
                try {
                  // Enviar la imagen para la detección y obtener la respuesta de la API
                  ApiResponse apiResponse =
                      await ApiService.sendImageForDetection(file!);

                  // Crear la página de detalles con la respuesta de la API
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScanDetailsPage(file!, apiResponse),
                    ),
                  );
                } catch (e) {
                  // Manejar errores, por ejemplo, mostrar un diálogo de error
                  print('Error: $e');
                  // Aquí puedes agregar lógica adicional según tus necesidades
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Debes seleccionar una imagen primero!'),
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            },
            color: const Color.fromARGB(255, 165, 36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "View Details",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCam() async {
    var img = await image.getImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        file = File(img.path);
      });
    }
  }

  Future<void> getGall() async {
    var img = await image.getImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        file = File(img.path);
      });
    }
  }
}
