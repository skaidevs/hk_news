import 'package:hk_news/src/models/news_item.dart';
import 'package:hk_news/src/resources/news_api.dart';
import 'package:hk_news/src/resources/news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
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

    //ELSE
    newsItem = await apiProvider.fetchNewsItem(id);
    //Add to DB
    dbProvider.addNewsItem(newsItem);

    return newsItem;
  }
}
