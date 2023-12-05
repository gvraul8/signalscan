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
  bool isLoading = false; // Nuevo estado para controlar la carga

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
                  "Seleccionar desde galería",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              MaterialButton(
                onPressed: () {
                  getCam();
                },
                color: const Color.fromARGB(255, 165, 36, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Tomar foto",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16),
            width:
                file == null ? 220.0 : MediaQuery.of(context).size.width * 0.8,
            height: file == null ? 220.0 : null,
            color: file == null
                ? const Color.fromARGB(66, 189, 188, 188)
                : Colors.transparent,
            child: file == null
                ? const Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.white,
                  )
                : AspectRatio(
                    aspectRatio:
                        file!.readAsBytesSync().lengthInBytes.toDouble() /
                            file!.readAsBytesSync().lengthInBytes.toDouble(),
                    child: Image.file(
                      file!,
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
          MaterialButton(
            onPressed: () async {
              if (file != null) {
                try {
                  setState(() {
                    isLoading = true;
                  });

                  ApiResponse apiResponse =
                      await ApiService.sendImageForDetection(file!);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanDetailsPage(file!, apiResponse),
                    ),
                  );
                } catch (e) {
                  throw 'Error: $e';
                } finally {
                  setState(() {
                    isLoading = false;
                  });
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
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    "Ver detalles",
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
