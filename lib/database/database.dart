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
      CREATE TABLE session (
        id VARCHAR(50) PRIMARY KEY,
        user_id INTEGER,
        partner_id INTEGER,
        user_login VARCHAR(50),
        user_name VARCHAR(50),
        password VARCHAR(50)
      )
    ''');
    await db.execute('''
      CREATE TABLE employee (
        id INTEGER PRIMARY KEY,
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

  Future<List<Map<String, dynamic>>> getAllQuery(String tableName) async {
    Database db = await instance.db;
    return await db.query(tableName);
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
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> truncateQuery(String tableName) async {
    Database db = await instance.db;
    return await db.delete(tableName);
  }
}
