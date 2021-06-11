import 'package:hk_news/src/models/news_item.dart';
import 'package:hk_news/src/resources/news_api.dart';
import 'package:hk_news/src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<NewsItem> fetchNewsItem(int id) async {
    NewsItem item;
    Source source;

    for (source in sources) {
      item = await source.fetchNewsItem(id);
      if (item != null) {
        break;
      }
    }

    //Add to DB
    for (var cache in caches) {
      cache.addNewsItem(item);
    }

    return item;
  }

  /*NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }
  Future<NewsItem> fetchNewsItem(int id) async {
    // Get Item from DB
    var newsItem = await dbProvider.fetchNewsItem(id);
    if (newsItem != null) {
      //Return newsItem
      return newsItem;
    }
    //ELSE Sending network request
    newsItem = await apiProvider.fetchNewsItem(id);
    //Add to DB
    dbProvider.addNewsItem(newsItem);

    return newsItem;
  }*/
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<NewsItem> fetchNewsItem(int id);
}

abstract class Cache {
  Future<int> addNewsItem(NewsItem item);
}
