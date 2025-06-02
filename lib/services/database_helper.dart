import 'dart:async';
// import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'app.db');

    return await openDatabase(
      path,
      version: 2, // versiyon 2 olsun
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // user_id sütununu ekle
          await db.execute('ALTER TABLE user_profile ADD COLUMN user_id TEXT UNIQUE');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_profile(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT UNIQUE,
        username TEXT,
        bio TEXT,
        profile_image TEXT
      )
    ''');
  }

  // Profil kaydetmek için
  Future<int> insertUserProfile(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('user_profile', row);
  }

  // Profil güncellemek için
  Future<int> updateUserProfile(Map<String, dynamic> row) async {
    final db = await database;
    return await db.update(
      'user_profile',
      row,
      where: 'user_id = ?',
      whereArgs: [row['user_id']],
    );
  }


  // Profili çekmek için (ilk satırı alıyoruz)
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final db = await database;
    final result = await db.query(
      'user_profile',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

}
