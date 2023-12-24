import 'package:daily_life_tasks_management/models/priority_task_model/priority_task_model.dart';
import 'package:daily_life_tasks_management/services/local_storage_priority_task/local_storage_priority_task.dart';
import 'package:daily_life_tasks_management/views/add_prioritize_tasks/add_prioritize_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowAllTasksScreen extends StatefulWidget {
  @override
  _ShowAllTasksScreenState createState() => _ShowAllTasksScreenState();
}

class _ShowAllTasksScreenState extends State<ShowAllTasksScreen> {
  List<PriorityTaskModel> tasks = []; // List to store the tasks

  @override
  void initState() {
    super.initState();
    _loadTasks();

    // Check and request permission for alarms when the screen is initialized
    _requestPermission();
  }

  Future<void> _loadTasks() async {
    List<PriorityTaskModel> loadedTasks = await TaskStorage.getTasks();
    loadedTasks.sort((a, b) => a.compareTo(b));
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<void> _requestPermission() async {
    var status = await Permission.speech.request();
    if (!status.isGranted) {
      // Handle the case where the user denied permission
      // You might want to display a message to the user
    }
  }

  void _stopAlarm() {
    FlutterRingtonePlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  AddTaskScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text('All Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'List of Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                FlutterRingtonePlayer.stop();
                Get.back(); // Stop the alarm manually
              },
              child: Text('Stop Alarm'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Dismissible(
                    key: Key(task.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      // Remove the item from the data source (tasks) and update the UI
                      setState(() {
                        tasks.removeAt(index);
                        TaskStorage.saveTask(tasks);
                      });

                      // Show a snackbar with the undo option
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Task ${task.name} has been deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Add the item back to the data source (tasks) and update the UI
                              setState(() {
                                tasks.insert(index, task);
                                TaskStorage.saveTask(tasks);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.teal),
                        child: ListTile(
                          title: Text(
                            task.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.description,
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(task.deadline.toString())
                            ],
                          ),
                          // Display other task details as needed
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}