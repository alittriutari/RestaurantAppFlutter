import 'package:path/path.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

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

  static const String _tableName = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'favorite_db.db'),
        onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABLE $_tableName (id TEXT PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL)''');
    }, version: 1);
    return db;
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteByRestaurantId(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
