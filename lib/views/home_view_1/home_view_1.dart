import 'dart:math' as math;

import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
import 'package:daily_life_tasks_management/main.dart';
import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeView1 extends StatefulWidget {
  const HomeView1({Key? key}) : super(key: key);

  @override
  State<HomeView1> createState() => _HomeView1State();
}

class _HomeView1State extends State<HomeView1> {
  NotificationServices notificationServices = NotificationServices();
  DateTime? deadline;
  tz.TZDateTime? scheduledDate; // Updated to TZDateTime
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
    checkNotificationDetails();
  }

  static Future<void> scheduleLocalNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required String payload,
  }) async {
    initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 4',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  void checkNotificationDetails() async {
    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null) {
      if (notificationAppLaunchDetails.didNotificationLaunchApp) {
        NotificationResponse? notificationResponse =
            notificationAppLaunchDetails.notificationResponse;
        if (notificationResponse != null) {
          String? payload = notificationResponse.payload;
          print(payload);
        }
      }
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  _clearTextFields() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    _timeController.clear();
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate!.isBefore(now)) {
      scheduledDate = scheduledDate!.add(const Duration(days: 1));
    }
    return scheduledDate!;
  }

  tz.TZDateTime _nextInstance(DateTime selectedDateTime) {
    final tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.local,
      selectedDateTime.year,
      selectedDateTime.month,
      selectedDateTime.day,
      selectedDateTime.hour,
      selectedDateTime.minute,
    );
    if (scheduledDateTime.isBefore(tz.TZDateTime.now(tz.local))) {
      return scheduledDateTime.add(const Duration(days: 0));
    }
    return scheduledDateTime;
  }

 Future<void> _addTask() async {
  try {
    String dateString = _dateController.text;
    String timeString = _timeController.text;

    String dateTimeString = "$dateString $timeString";
    DateTime parsedDateTime =
        DateFormat("yyyy-MM-dd HH:mm").parse(dateTimeString);

    // Convert parsedDateTime to TZDateTime
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(parsedDateTime, tz.local);

    // Check if the scheduled date is in the future
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print('Scheduled date must be in the future.');
      return;
    }

    Task task = Task(
      id: null,
      title: _titleController.text,
      description: _descriptionController.text,
      deadline: scheduledDate,
    );

    int result = await dbHelper.insertTask(task);
    if (result != 0) {
      // Schedule local notification using scheduledDate
      int id = math.Random().nextInt(10000);
      await scheduleLocalNotification(
        id: id,
        title: task.title,
        body:
            "${task.title} has ${DateFormat("yyyy-MM-dd HH:mm").format(scheduledDate)} deadline",
        scheduledDate: scheduledDate,
        payload: "",
      );

      print("Scheduled ${scheduledDate.toLocal()}");
      setState(() {});
      _clearTextFields(); // Move this line here to clear the text fields after successful scheduling
    } else {
      print('Failed to insert task into the database.');
    }
  } catch (e) {
    print('Error parsing DateTime: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: dbHelper.getTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<Task> tasks = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index].title),
                      subtitle: Text('Deadline: ${tasks[index].deadline}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTaskDialog() async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          _dateController.text =
              selectedDate.toLocal().toString().split(' ')[0];
        });
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null && pickedTime != selectedTime) {
        setState(() {
          selectedTime = pickedTime;
          _timeController.text = selectedTime.format(context);
        });
      }
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('My Task List'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextField(
                            controller: _dateController,
                            decoration:
                                InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context),
                        child: IgnorePointer(
                          child: TextField(
                            controller: _timeController,
                            decoration:
                                InputDecoration(labelText: 'Time (HH:MM)'),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _selectTime(context),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
                Navigator.pop(context);
                _clearTextFields();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
