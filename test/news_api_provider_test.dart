import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hk_news/src/resources/news_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    //setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4, 5, 6, 7]), 200);
    });

    //expect
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4, 5, 6, 7]);
  });

  test('fetchIem returns a news Model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchNewsItem(789);
    expect(item.id, 123);
  });
}
