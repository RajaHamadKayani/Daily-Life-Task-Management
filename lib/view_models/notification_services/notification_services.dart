import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:daily_life_tasks_management/views/home_view/home_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServies {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  void requestNotificationsPermissions() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      announcement: true,
      criticalAlert: true,
      carPlay: true,
      badge: true,
      sound: true,
      alert: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      Get.snackbar("Task Monitoring", "Access granted Successfully");
      print("Access granted Successfully");
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Get.snackbar(
          "Task Monitoring", "Provisional Access granted Successfully");
      print("Provisional Access granted Successfully");
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      Get.snackbar("Task Monitoring", "Access denied");
      print("Access denied");
    }
  }

  Future<String> getDeviceToken() async {
    // this is for getting the unique token when the notification permission granted for further usage in an app
    String? token = await firebaseMessaging.getToken();
    return token!;
  }

  void firebaseInit(BuildContext context, String? habitName, DateTime? dateTime) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Received FCM message: ${message.data}');

      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      // Assuming you have a habit name and deadline time in the FCM message payload
      // String habitName = message.data['habitName'];
      // String deadlineTimeString = message.data['deadlineTime'];
      // DateTime deadlineTime = DateTime.parse(deadlineTimeString);

      // Schedule the notification for the habit deadline
      // if (DateTime.now() == deadlineTime) {
      //   scheduleNotification(habitName, deadlineTime);
      // }
      if (kDebugMode) {
        print(message.data.toString());
        print(message.data["key"]);
        print(message.data["id"]);
      }

      initLocalNotificationPlugin(context, message);

      showNotifications(message,habitName ?? "",dateTime!);
    });
  }

  void initLocalNotificationPlugin(
      BuildContext context, RemoteMessage message) async {
    // this is for initializing the notifications for andoid and ios devices
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher.png");
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleFirebaseMessage(context, message);
    });
  }

  Future<void> showNotifications(
      RemoteMessage? message, String habitName, DateTime dateTime) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        "High Importance Notifications",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            priority: Priority.high,
            importance: Importance.high,
            channelDescription: "Your channel description",
            ticker: "ticker");
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.periodicallyShow(
          0,
          "Habit Alert!",
          "Your habit \"$habitName\" deadline time has arrived. And deadline time is $dateTime",
          RepeatInterval.everyMinute,
          notificationDetails);
    });
  }
  // Future<void> scheduleNotification(String habitName, DateTime dateTime) async {
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     Random.secure().nextInt(100000).toString(),
  //     "High Importance Notifications",
  //     importance: Importance.max,
  //   );

  //   AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     channel.id.toString(),
  //     channel.name.toString(),
  //     priority: Priority.high,
  //     importance: Importance.high,
  //     channelDescription: "Your channel description",
  //     ticker: "ticker",
  //   );

  //   DarwinNotificationDetails darwinNotificationDetails =
  //       const DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );

  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: darwinNotificationDetails,
  //   );

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0,
  //     "Habit Reminder",
  //     "Your habit \"$habitName\" deadline time has arrived.",
  //     tz.TZDateTime.from(dateTime, tz.local),
  //     notificationDetails,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  void refereshToken() async {
    firebaseMessaging.onTokenRefresh.listen((message) {
      message.toString();
      print(message);
    });
  }

  void handleFirebaseMessage(
      BuildContext context, RemoteMessage message) async {
    if (message.data["key"] == "message") {
      Get.to(HomeView());
      print("Successfully navigated to home screen");
    } else {
      print("failed to navigate to home screen");
    }
  }

  Future<void> setUpInteractMessage(BuildContext context) async {
    // navigating to the desired screen when the app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleFirebaseMessage(context, initialMessage);
    } else {
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        handleFirebaseMessage(context, event);
      });
    }
  }
}
