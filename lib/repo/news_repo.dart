import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsRepository {
  final String _baseUrl = "https://newsapi.org/v2/top-headlines";
  final String _apiKey = "582b934a633f4fd3ac752685d6829dd5"; //new generated api
  Future<List<Article>> fetchNews(String country) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl?country=$country&apiKey=$_apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['articles'] as List)
            .map((json) => Article.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
