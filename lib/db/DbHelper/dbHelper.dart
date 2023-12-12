import 'package:sqflite/sqflite.dart';

import '../../models/task/task.dart';

class DbHelper {
  static Database? db;
  static final dbName = "taskstable";
  static final int version = 1;
  static Future<void> initDb() async {
    if (db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() +
          "/taskstable.db"; // Add '/' before the filename
      print("creating table in db");
      db = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $dbName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int> insertData(Task? task) async {
    print("insertion function called");
    return await db?.insert(dbName, task!.toJson()) ?? 9;
  }

  static Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await db?.query(dbName) ?? [];
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    return await db!.query(dbName);
  }

  static delete(Task task) async {
    return await db!.delete(dbName, where: "id=?", whereArgs: [task.id]);
  }

  static  updateTask(int id) {
    db!.rawUpdate('''
UPDATE taskstable
SET isCompleted=?
WHERE id=?
''', [1, id]);
  }
}
