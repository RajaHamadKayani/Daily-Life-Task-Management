import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math' as math;
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:daily_life_tasks_management/main.dart';

class NotificationServices {
  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon_1');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((response) {
      String? result = response.payload;
      print(result);
    }));
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to flutter"));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  scheduledNotification({
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

  

    int id = math.Random().nextInt(10000);
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}
