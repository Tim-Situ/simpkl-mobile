import 'dart:async';
import 'package:path/path.dart';
import 'package:simpkl_mobile/models/pembimbing_model.dart';
import 'package:simpkl_mobile/models/perusahaan_model.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/models/notification_model.dart';
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
            alamat TEXT,
            no_hp TEXT,
            tempat_lahir TEXT,
            tanggal_lahir TEXT,
            jurusan TEXT,
            status_aktif INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE pembimbing (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nip TEXT,
            nama TEXT,
            alamat TEXT,
            no_hp TEXT,
            status_aktif INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE perusahaan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_perusahaan TEXT,
            pimpinan TEXT,
            alamat TEXT,
            no_hp TEXT,
            email TEXT,
            website TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE notifikasi (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            body TEXT,
            createdAt TEXT
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
    return db.insert('profile', {
      'nisn': profile.nisn,
      'nama': profile.nama,
      'alamat': profile.alamat,
      'no_hp': profile.noHp,
      'tempat_lahir': profile.tempatLahir,
      'tanggal_lahir': profile.tanggalLahir.toIso8601String(),
      'status_aktif': profile.statusAktif == true ? 1 : 0,
      'jurusan': profile.jurusan
    });
  }

  Future<int> insertPembimbing(PembimbingModel pembimbing) async {
    final db = await database;
    return db.insert('pembimbing', {
      'nip': pembimbing.nip,
      'nama': pembimbing.nama,
      'alamat': pembimbing.alamat,
      'no_hp': pembimbing.noHp,
      'status_aktif': pembimbing.statusAktif == true ? 1 : 0
    });
  }

  Future<int> insertPerusahaan(PerusahaanModel perusahaan) async {
    final db = await database;
    return db.insert('perusahaan', {
      'nama_perusahaan': perusahaan.nama_perusahaan,
      'pimpinan': perusahaan.pimpinan,
      'alamat': perusahaan.alamat,
      'no_hp': perusahaan.no_hp,
      'email': perusahaan.email,
      'website': perusahaan.website
    });
  }

  Future<void> insertNotification(Notifikasi notification) async {
    final db = await database;
    await db.insert(
      'notifikasi',
      notification.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<ProfileModel> getProfile() async {
    final db = await database;
    final result = await db.query('profile', limit: 1, orderBy: 'id DESC');

    return ProfileModel.fromMap(result.first);
  }

  Future<PembimbingModel> getPembimbing() async {
    final db = await database;
    final result = await db.query('pembimbing', limit: 1, orderBy: 'id DESC');

    return PembimbingModel.fromMap(result.first); 
  }

  Future<PerusahaanModel> getPerusahaan() async {
    final db = await database;
    final result = await db.query('perusahaan', limit: 1, orderBy: 'id DESC');

    return PerusahaanModel.fromMap(result.first); 
  }

  Future<String?> getToken() async {
    final db = await database;
    final result = await db.query('token', limit: 1, orderBy: 'id DESC');
    if (result.isNotEmpty) {
      return result.first['access_token'] as String;
    }
    return null;
  }

  Future<List<Notifikasi>> getNotifications() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notifikasi');

    return List.generate(maps.length, (i) {
      return Notifikasi.fromMap(maps[i]);
    });
  }

  Future<int> deleteToken() async {
    final db = await database;
    return db.delete('token');
  }

  Future<int> deleteProfile() async {
    final db = await database;
    return db.delete('profile');
  }

  Future<int> deletePembimbing() async {
    final db = await database;
    return db.delete('pembimbing');
  }
  
  Future<int> deletePerusahaan() async {
    final db = await database;
    return db.delete('perusahaan');
  }

  Future<void> deleteNotification(int id) async {
    final db = await database;
    await db.delete(
      'notifikasi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> checkDuplicateNotification(String title, String body) async {
    final db = await database;
    final result = await db.query(
      'notifikasi',
      where: 'title = ? AND body = ?',
      whereArgs: [title, body],
    );
    return result.isNotEmpty;
  }

  Future<int> getNotificationCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) AS count FROM notifikasi'
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}
