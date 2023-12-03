import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsAPIService {
  Future<List<Article>> getNews() async {
    const apiUrl = "https://newsapi.ai/api/v1/article/getArticles";
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'query': {
        '\$query': {
          '\$and': [
            {"conceptUri": "http://en.wikipedia.org/wiki/Traffic_sign"},
            {"locationUri": "http://en.wikipedia.org/wiki/Spain"}
          ]
        },
        '\$filter': {"forceMaxDataTimeWindow": "31"}
      },
      "resultType": "articles",
      "articlesSortBy": "date",
      "apiKey": "9758aa6b-d20f-4ef3-b173-5c8dd728f176"
    };


    final response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // Verifica si la clave 'articles' y 'results' existen en la respuesta
      if (data.containsKey('articles') && data['articles'].containsKey('results')) {
        final List<dynamic> articlesData = data['articles']['results'];

        List<Article> articles = articlesData
            .map((articleData) => Article.fromJson(articleData))
            .toList();

        return articles;
      } else {
        throw Exception('Invalid response structure: articles or results not found');
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}