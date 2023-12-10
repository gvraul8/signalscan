import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa la librería para lanzar URLs
import 'package:url_launcher/url_launcher_string.dart';
import '../models/article_model.dart';

class NewsDetailsPage extends StatefulWidget {
  final Article article;

  const NewsDetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    String bodyText = widget.article.body;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 36, 36),
        title: Text(widget.article.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.article.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 54, 120, 244),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  widget.article.source.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  showFullText ? bodyText : _truncateText(bodyText, 200),
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 165, 36, 36),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showFullText = !showFullText;
                      });
                    },
                    child: Text(showFullText ? 'Leer menos' : 'Leer más'),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromARGB(255, 165, 36, 36),
                      ),
                    ),
                    onPressed: () async {
                      await launchUrlString(widget.article.url);
                    },
                    child: const Text('Ver en detalle'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    return text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
  }
}
