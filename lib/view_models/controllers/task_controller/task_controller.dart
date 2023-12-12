import 'package:daily_life_tasks_management/db/DbHelper/dbHelper.dart';
import 'package:daily_life_tasks_management/models/task/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchTasks(); // Automatically fetch tasks when the controller is initialized
  }

  fetchTasks() async {
    taskList.assignAll(
        await DbHelper.getAllTasks()); // Add a method to get all tasks
  }

  // void getTasks() async {
  //   List<Map<String, dynamic>> tasks = await DbHelper.getData();
  //   taskList.assignAll((taskList).map((data) => Task.fromJson(data)).toList());
  // }

  addDataToTaskModel(Task? task) async {
    return await DbHelper.insertData(task!);
  }

  void delete(Task task) async {
    await DbHelper.delete(task);
  }

  markTheTaskCompleted(int id) async {
    await DbHelper.updateTask(id);
  }
}
