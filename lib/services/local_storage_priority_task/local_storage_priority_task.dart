import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/priority_task_model/priority_task_model.dart';

class TaskStorage {
  static const String taskKey = 'tasks';

  static Future<List<PriorityTaskModel>> getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? storedTasks = prefs.getStringList(taskKey);

    if (storedTasks != null) {
      List<PriorityTaskModel> tasks = storedTasks.map((task) => PriorityTaskModel.fromJson(json.decode(task))).toList();
      return tasks;
    }

    return [];
  }

  static Future<void> saveTask(List<PriorityTaskModel> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedTasks = tasks.map((task) => json.encode(task.toJson())).toList();

    prefs.setStringList(taskKey, encodedTasks);
  }

  static void addTask(PriorityTaskModel newTask) async {
    List<PriorityTaskModel> tasks = await getTasks();
    tasks.add(newTask);
    await saveTask(tasks);
  }
}