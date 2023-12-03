class Article {
  String date;
  String url;
  String title;
  String body;
  Source source;
  String image;
  int relevance;

  Article({
    required this.date,
    required this.url,
    required this.title,
    required this.body,
    required this.source,
    required this.image,
    required this.relevance,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      date: json['date'],
      url: json['url'],
      title: json['title'],
      body: json['body'],
      source: Source.fromJson(json['source']),
      image: json['image'],
      relevance: json['relevance'],
    );
  }
}

class Source {
  String uri;
  String dataType;
  String title;

  Source({
    required this.uri,
    required this.dataType,
    required this.title,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      uri: json['uri'],
      dataType: json['dataType'],
      title: json['title'],
    );
  }
}
