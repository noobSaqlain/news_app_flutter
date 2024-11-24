class Article {
  final String? title;
  final String? description;
  final String? author;
  final String? urlToImage;
  final String? content;
  final String? publishedAt;

  Article(
      {this.title,
      this.description,
      this.author,
      this.urlToImage,
      this.content,
      this.publishedAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      author: json['author'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      publishedAt: json['publishedAt'],
    );
  }
}
