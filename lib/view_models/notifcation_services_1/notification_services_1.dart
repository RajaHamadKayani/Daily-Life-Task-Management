import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices1 {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings("logo");
  void initializeSettings() async {
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void schedualeNotification(String taskName, dynamic dateTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            "channel_id", "High importance channel",
            priority: Priority.high,
            importance: Importance.max,
            ticker: "ticker",
            channelDescription: "Task Monitoring App");
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        "Task Alert!",
        "$taskName has $dateTime deadline",
        RepeatInterval.everyMinute,
        notificationDetails);
  }
}
