import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/model/favorite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static String _tableName = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'favorite_db.db'), onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableName (id TEXT PRIMARY KEY, name TEXT, pictureId TEXT, city TEXT, rating REAL, isFavorite INTEGER )''');
    }, version: 1);
    return db;
  }

  Future<void> addFavorite(Favorite favorite) async {
    final Database db = await database;
    await db.insert(_tableName, favorite.toMap());
    print('added to favorite');
  }

  Future<List<Favorite>> getFavorite() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<Favorite> getFavoriteByRestaurantId(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    print(results.map((e) => Favorite.fromMap(e)).first);
    return results.map((e) => Favorite.fromMap(e)).first;
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
