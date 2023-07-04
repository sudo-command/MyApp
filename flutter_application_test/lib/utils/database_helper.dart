import 'package:flutter_application_test/Models/todo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'todos.db');

    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS MyTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertData(TodoModel todo) async {
    var dbClient = await database;
    return await dbClient.insert('MyTable', todo.toJson());
  }

  Future<int> updateData(TodoModel todo) async {
    var dbClient = await database;
    return await dbClient.update(
      'MyTable',
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteData(String id) async {
    var dbClient = await database;
    return await dbClient.delete(
      'MyTable',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TodoModel>> getAllData() async {
    var dbClient = await database;
    var result = await dbClient.query('MyTable');
    return result.map((json) => TodoModel.fromJson(json)).toList();
  }

  Future<TodoModel?> getDataById(int id) async {
    var dbClient = await database;
    var result = await dbClient.query(
      'MyTable',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return TodoModel.fromJson(result.first);
    } else {
      return null;
    }
  }
}
