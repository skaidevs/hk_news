import 'dart:io';

import 'package:hk_news/src/models/news_item.dart';
import 'package:hk_news/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  Future<void> init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'hk_news.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""CREATE TABLE NewsItems 
      (
      id INTEGER PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
      )
      """);
    });
  }

  Future<NewsItem> fetchNewsItem(int id) async {
    final maps = await db.query(
      'NewsItems',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return NewsItem.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addNewsItem(NewsItem newsItem) {
    return db.insert('NewsItems', newsItem.toMapForDb());
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    throw UnimplementedError();
  }
}

final newsDbProvider = NewsDbProvider();
