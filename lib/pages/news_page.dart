import 'package:flutter/material.dart';
import '../components/news_list_tile.dart';
import '../models/article_model.dart';
import '../services/news_api_service.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsAPIService client = NewsAPIService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 165, 36, 36),
          title: const Text('Noticias'),
        ),
        body: FutureBuilder(
          future: client.getNews(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                  itemCount: articles?.length,
                  itemBuilder: (context, index) =>
                      NewsListTile(articles![index], context));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
