import 'package:dpp_mobile/database/table_queries/attendance_query.dart';
import 'package:dpp_mobile/database/table_queries/employee_query.dart';
import 'package:dpp_mobile/database/table_queries/host_query.dart';
import 'package:dpp_mobile/database/table_queries/session_query.dart';
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

    return await openDatabase(
      path,
      version: 2, // Increment version to trigger onUpgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(hostCreateTable);
    await db.execute(sessionCreateTable);
    await db.execute(employeeCreateTable);
    await db.execute(attendanceCreateTable);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add login_state column if it doesn't exist
      try {
        await db.execute('ALTER TABLE session ADD COLUMN login_state INTEGER DEFAULT 0');
      } catch (e) {
        // Column might already exist, ignore error
      }
    }
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
