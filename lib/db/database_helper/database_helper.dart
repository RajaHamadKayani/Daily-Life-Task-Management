import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "notes.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');
  }

  Future<TaskModel> insertData(TaskModel taskModel) async {
    var dbClient = await db;
     taskModel.dateTimeString = taskModel.dateTime.toIso8601String();
    await dbClient!.insert("notes", taskModel.toMap());
    return taskModel;
  }

  Future<List<TaskModel>> getData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> getData = await dbClient!.query("notes");
    return getData.map((e) => TaskModel.jsonMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient!.delete("notes", where: "id=?", whereArgs: [id]);
  }
}
