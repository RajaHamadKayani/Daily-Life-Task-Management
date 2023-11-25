// import 'dart:math';

// import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
// import 'package:daily_life_tasks_management/main.dart';
// import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
// import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:daily_life_tasks_management/main.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final DatabaseHelper dbHelper = DatabaseHelper();

//   @override
//   void initState() {
//     super.initState();

//     checkNotficationDetails();
//   }

//  Future<void> _showNotification(String title, String body, DateTime time) async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails('your_channel_id', 'your_channel_name',
//           importance: Importance.max, priority: Priority.max);
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//     android: androidPlatformChannelSpecifics,
//   );

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     title,
//     body,
//     tz.TZDateTime.from(time, tz.local), // Use tz.TZDateTime.from(time, tz.local)
//     platformChannelSpecifics,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.wallClockTime,
//     androidAllowWhileIdle: true,
//     payload: "dmdkmdv",
//   );
// }


//   void checkNotficationDetails() async {
//     NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     if (notificationAppLaunchDetails != null) {
//       if (notificationAppLaunchDetails.didNotificationLaunchApp) {
//         NotificationResponse? notificationResponse =
//             notificationAppLaunchDetails.notificationResponse;
//         if (notificationResponse != null) {
//           String? payload = notificationResponse.payload;
//           print(payload);
//         }
//       }
//     }
//   }

//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();


// // ...

// Future<void> _addTask() async {
//   try {
//     // Format date and time strings
//     String dateString = _dateController.text;
//     String timeString = _timeController.text;

//     // Parse date and time using DateFormat
//     DateTime deadline = DateFormat("yyyy-MM-dd HH:mm").parse('$dateString $timeString');

//     Task task = Task(
//       id: null,
//       title: _titleController.text,
//       description: _descriptionController.text,
//       deadline: deadline,
//     );

//     int result = await dbHelper.insertTask(task);
//     if (result != 0) {
//       String formattedDateTime = DateFormat("yyyy-MM-dd HH:mm").format(deadline);

//       _showNotification(
//         task.title,
//         "${task.title} has $formattedDateTime deadline",
//         DateTime.parse(formattedDateTime),
//       );

//       _clearTextFields();
//       setState(() {});
//     } else {
//       print('Failed to insert task into the database.');
//     }
//   } catch (e) {
//     print('Error parsing DateTime: $e');
//     // Handle the error as needed (e.g., show a user-friendly message)
//   }
// }



//   void _clearTextFields() {
//     _titleController.clear();
//     _descriptionController.clear();
//     _dateController.clear();
//     _timeController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task List'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Task>>(
//               future: dbHelper.getTasks(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }

//                 List<Task> tasks = snapshot.data!;
//                 return ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index].title),
//                       subtitle: Text('Deadline: ${tasks[index].deadline}'),
//                       // Add other details if needed
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddTaskDialog(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> _showAddTaskDialog() async {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//         _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );

//     if (pickedTime != null && pickedTime != selectedTime) {
//       setState(() {
//         selectedTime = pickedTime;
//         _timeController.text = selectedTime.format(context);
//       });
//     }
//   }

//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Add Task'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => _selectDate(context),
//                       child: IgnorePointer(
//                         child: TextField(
//                           controller: _dateController,
//                           decoration:
//                               InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.calendar_today),
//                     onPressed: () => _selectDate(context),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () => _selectTime(context),
//                       child: IgnorePointer(
//                         child: TextField(
//                           controller: _timeController,
//                           decoration:
//                               InputDecoration(labelText: 'Time (HH:MM)'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.access_time),
//                     onPressed: () => _selectTime(context),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               _addTask();
//               Navigator.pop(context);
//             },
//             child: Text('Add'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//         ],
//       );
//     },
//   );
// }

// }
