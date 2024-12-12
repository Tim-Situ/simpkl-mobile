import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'prakeran_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE token (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            access_token TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertToken(String token) async {
    final db = await database;
    return db.insert('token', {'access_token': token});
  }

  Future<String?> getToken() async {
    final db = await database;
    final result = await db.query('token', limit: 1, orderBy: 'id DESC');
    if (result.isNotEmpty) {
      return result.first['access_token'] as String;
    }
    return null;
  }

  Future<int> deleteToken() async {
    final db = await database;
    return db.delete('token');
  }
  
}
