import 'package:daily_life_tasks_management/views/dashboard/dashboard.dart';
import 'package:daily_life_tasks_management/views/prioritize_task_view/prioritize_task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../models/priority_task_model/priority_task_model.dart';
import '../../services/local_storage_priority_task/local_storage_priority_task.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime _deadline =
      DateTime.now(); // Default deadline is set to current date and time

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = DateTime(picked.year, picked.month, picked.day,
            _deadline.hour, _deadline.minute);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );

    if (picked != null) {
      setState(() {
        _deadline = DateTime(_deadline.year, _deadline.month, _deadline.day,
            picked.hour, picked.minute);
      });
    }
  }

  void _addTask() {
    // Create a Task object using the entered data
    PriorityTaskModel newTask = PriorityTaskModel(
      id: DateTime.now()
          .millisecondsSinceEpoch, // Unique identifier using current timestamp
      name: _nameController.text,
      description: _descriptionController.text,
      deadline: _deadline,
    );

    // Save the new task to local storage
    TaskStorage.addTask(newTask);
    // Play alarm if the deadline is within 5 minutes
    final Duration difference = _deadline.difference(DateTime.now());
    if (difference.inMinutes <= 5) {
      FlutterRingtonePlayer.playRingtone();
    }

    // Navigate to the screen displaying all tasks
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShowAllTasksScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text('Deadline: ${_deadline.toLocal()}'),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addTask, // Call the _addTask function on button press
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
