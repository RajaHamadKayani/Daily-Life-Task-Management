// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:math' as math;
// import 'package:timezone/data/latest.dart' as tz;

// import 'package:daily_life_tasks_management/main.dart';

// import '../../models/task/task.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';

// class NotificationServices {
//   Future<void> initializeNotifications() async {
//     getLocalTimeZone();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings("icon_1");
//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//             requestSoundPermission: false,
//             requestBadgePermission: false,
//             requestAlertPermission: false,
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: ((response) {
//       String? result = response.payload;
//       print(result);
//     }));
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     Get.dialog(Text("Welcome to flutter"));
//   }

//   void requestIOSPermissions() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   displayNotification({required String title, required String body}) async {
//     print("doing test");
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your channel id', 'your channel name',
//         importance: Importance.max, priority: Priority.high);
//     DarwinNotificationDetails iOSPlatformChannelSpecifics =
//         DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'It could be anything you pass',
//     );
//   }

//   scheduledNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'scheduled title',
//         'theme changes 5 seconds ago',
//         tz.TZDateTime.from(DateTime.now().add(const Duration(seconds: 5)), tz.local),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//           'your channel id',
//           'your channel name',
//         )),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   tz.TZDateTime _nextInstanceOfDailyTask(int hours, int minutes) {
//     tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       hours,
//       minutes,
//     );

//     // If the scheduled time is in the past, move it to the next day
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     return scheduledDate;
//   }

//   Future<void> getLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//   }

//   tz.TZDateTime convertTime(int hours, int minutes) {
//     tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
//     if (scheduleDate.isBefore(now)) {
//       scheduleDate = scheduleDate.add(const Duration(days: 1));
//     }
//     return scheduleDate;
//   }
// }
