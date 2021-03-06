import 'dart:convert';

import 'package:hk_news/src/models/news_item.dart';
import 'package:hk_news/src/resources/repository.dart';
import 'package:http/http.dart' as http;

final _baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  http.Client client = http.Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get(
      Uri.parse('$_baseUrl/topstories.json'),
    );
    final ids = json.decode(
      response.body,
    );

    return ids.cast<int>();
  }

  Future<NewsItem> fetchNewsItem(int id) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/v0/item/$id.json'),
    );
    final parsedJson = json.decode(response.body);

    return NewsItem.fromJson(parsedJson);
  }
}
