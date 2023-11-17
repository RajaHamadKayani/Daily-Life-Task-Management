import 'package:daily_life_tasks_management/view_models/controllers/cron_controller/cron_controller.dart';
import 'package:daily_life_tasks_management/view_models/notifcation_services_1/notification_services_1.dart';
import 'package:daily_life_tasks_management/views/login_view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main(context) async {
  // CronController cronController = CronController();
  // cronController.cronMethod( null,null);
  // ignore: unused_local_variable
  // NotificationServices1 notificationServices1 = NotificationServices1();

  WidgetsFlutterBinding.ensureInitialized();
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginView(),
    );
  }
}
