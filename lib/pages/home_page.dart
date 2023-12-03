import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signalscan/pages/signal_scan_details_page.dart';
import 'package:signalscan/services/signals_detection_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  "Take from camera",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 240,
            width: 280,
            color: Colors.black12,
            child: file == null
                ? const Icon(
                    Icons.image,
                    size: 50,
                  )
                : Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
          ),
          MaterialButton(
            onPressed: () async {
              if (file != null) {
                try {
                  String apiResponse =
                      await ApiService.sendImageForDetection(file!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              apiResponse: apiResponse,
                              imageFile: file!,
                            )),
                  );
                } catch (e) {
                  print('Error: $e');
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
