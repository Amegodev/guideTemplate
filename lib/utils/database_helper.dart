import 'dart:io';

import 'package:guideTemplate/models/article_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TemplateDatabaseProvider {

  TemplateDatabaseProvider();

  Database _database;

/* Future<Database> _getDb() async {
  if (_database != null)
  return _database;
  // if _database is null we instantiate it
  _database = await initDB();
  return _database;
} */

  Future<Database> getdatabase() async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'myData', 'articles.db');
    return await openDatabase(path);
  }

  Future<List<Article>> getAllArticles() async {
    final db = await getdatabase();
    //print('from getAllArticles : path = ${this.path}');
    // Building SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)
    List<Map> jsons = await db.rawQuery('SELECT * FROM ${Article.dbTable}');
    //print('${jsons.length} rows retrieved from db!');
    return jsons.map((json) => Article.fromMap(json)).toList();
  }

  Future<Article> getArticl(int id) async{
    var db = await getdatabase();
    var result = await db.rawQuery(
        'SELECT * FROM ${Article.dbTable} WHERE ${Article.dbId} = "$id"');
    if(result.length == 0)return null;
    return new Article.fromMap(result[0]);
  }
}