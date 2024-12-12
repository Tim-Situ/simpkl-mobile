import 'dart:async';
import 'package:path/path.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
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

        await db.execute('''
          CREATE TABLE profile (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nisn TEXT,
            nama TEXT,
            jurusan TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertToken(String token) async {
    final db = await database;
    return db.insert('token', {'access_token': token});
  }

  Future<int> insertProfile(ProfileModel profile) async {
    final db = await database;
    return db.insert('profile', 
      {
        'nisn': profile.nisn,
        'nama': profile.nama,
        'jurusan': profile.jurusan
      });
  }

  Future<ProfileModel> getProfile() async {
    final db = await database;
    final result = await db.query('profile', limit: 1, orderBy: 'id DESC');
    
    // Periksa jika result tidak kosong dan konversi data ke ProfileModel

      return ProfileModel.fromMap(result.first); // Ambil data pertama jika ada
    
  // Atau kembalikan ProfileModel kosong sesuai kebutuhan
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
