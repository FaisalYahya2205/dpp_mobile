import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dpp.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE host_address (
        user_id INTEGER UNIQUE,
        host_url VARCHAR(50),
        database_name VARCHAR(50)
      )
    ''');
    await db.execute('''
      CREATE TABLE session (
        user_id INTEGER PRIMARY KEY UNIQUE,
        partner_id INTEGER UNIQUE,
        session_id VARCHAR(50),
        user_login VARCHAR(50) UNIQUE,
        user_name VARCHAR(50) UNIQUE,
        password VARCHAR(50),
        login_state INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE employee (
        id INTEGER PRIMARY KEY,
        user_id INTEGER,
        name VARCHAR(50),
        nrp VARCHAR(10),
        job_id VARCHAR(50),
        job_title VARCHAR(50),
        work_email VARCHAR(100),
        work_phone VARCHAR(15),
        address_id VARCHAR(50),
        coach_id VARCHAR(50),
        __last_update VARCHAR(50),
        image_128 TEXT,
        image_1920 TEXT,
        tz VARCHAR(100)
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAllQuery(
      String tableName, String where, List<dynamic> whereAgrs) async {
    Database db = await instance.db;
    return await db.query(
      tableName,
      where: where,
      whereArgs: whereAgrs,
    );
  }

  Future<int> countQuery(
      String tableName, String where, List<dynamic> whereAgrs) async {
    Database db = await instance.db;
    final result = await db.query(
      tableName,
      where: where,
      whereArgs: whereAgrs,
    );
    return result.length;
  }

  Future<int> insertQuery(String tableName, Map<String, dynamic> model) async {
    Database db = await instance.db;
    return await db.insert(
      tableName,
      model,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteQuery(String tableName, int id) async {
    Database db = await instance.db;
    return await db
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> truncateQuery(String tableName) async {
    Database db = await instance.db;
    return await db.delete(tableName);
  }

  Future<int> logoutQuery(String tableName) async {
    Database db = await instance.db;
    return await db.update(
      tableName,
      {"login_state": 0},
    );
  }
}
