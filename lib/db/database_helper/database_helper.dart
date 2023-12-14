// import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// class DatabaseHelper {
//   static const String tableName = 'tasks';

//   Future<Database> initializeDatabase() async {
//     final String path = join(await getDatabasesPath(), 'tasks.db');
//     return openDatabase(path, version: 1, onCreate: (Database db, int version) async {
//     await db.execute(
//     'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, deadline TEXT)');

//     });
//   }

//   Future<int> insertTask(Task task) async {
//     Database db = await initializeDatabase();
//     return await db.insert(tableName, task.toMap());
//   }

//   Future<List<Task>> getTasks() async {
//     Database db = await initializeDatabase();
//     List<Map<String, dynamic>> maps = await db.query(tableName);
//     return List.generate(maps.length, (i) {
//       return Task(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         description: maps[i]['description'],
//         deadline: DateTime.parse(maps[i]['deadline']),
//       );
//     });
//   }
// }