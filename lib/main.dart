import 'package:daily_life_tasks_management/view_models/app_themes/appthemes.dart';
import 'package:daily_life_tasks_management/views/home_view_1/home_view_1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:timezone/data/latest_10y.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon_1');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) {
      print(response.payload.toString());
    });
  }

  initializeTimeZones();
  // NotificationServices1().initializeSettings();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);

  runApp(MyApp());
}

// Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print(message.notification!.title.toString());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.light,
      home: const HomeView1(),
    );
  }
}
