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

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4, 5, 6, 7]);
  });
}
