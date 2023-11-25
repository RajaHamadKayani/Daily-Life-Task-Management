// import 'dart:html';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:daily_life_tasks_management/main.dart';
// import 'package:battery_plus/battery_plus.dart';
// class BatteryAlarm extends StatefulWidget {
//   @override
//   _BatteryAlarmState createState() => _BatteryAlarmState();
// }

// class _BatteryAlarmState extends State<BatteryAlarm> {
//   Battery _battery = Battery();
//   bool _isPermissionGranted = false;
//   FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionStatus();
//     _initializeNotifications();
//   }

//   Future<void> _checkPermissionStatus() async {
//     final status = await Permission.notification.status;
//     setState(() {
//       _isPermissionGranted = status == PermissionStatus.granted;
//     });
//   }

//   Future<void> _requestPermission() async {
//     final status = await Permission.notification.request();
//     setState(() {
//       _isPermissionGranted = status == PermissionStatus.granted;
//     });
//   }

//   void _initializeNotifications() {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void _startBatteryListener() {
//     _battery.onBatteryStateChanged.listen((BatteryState state) {
//       if (state == BatteryState.full && _isPermissionGranted) {
//         // Battery is fully charged, generate alarm here
//         _generateAlarm();
//       }
//     });
//   }

//   void _generateAlarm() async {
//     // Display a notification with sound
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'battery_channel',
//       'Battery Channel',
//       sound: RawResourceAndroidNotificationSound('notification_sound'),
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       'Battery Alarm',
//       'Battery is fully charged!',
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Battery Alarm'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Battery Alarm',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _requestPermission();
//               },
//               child: Text('Request Permission'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _startBatteryListener();
//               },
//               child: Text('Start Battery Listener'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }