import 'package:sqflite/sqflite.dart';
import 'package:fluuter_interm_restaurant_app/models/model_restaurant_list.dart';

class DbHelper {
  static DbHelper? _instance;
  static Database? _database;

  DbHelper._internal() {
    _instance;
  }

  factory DbHelper() => _instance ?? DbHelper._internal();

  static const String _tblFavorite = 'restaurant';

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();

    final db = openDatabase(
      '$path/restaurant_fav.db',
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $_tblFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DOUBLE
          )
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    return _database ??= await _initializeDb();
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((item) => Restaurant.fromJson(item)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
