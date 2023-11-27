import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestIOSPermissions();
    notificationServices.initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                onTap: () {
                  notificationServices.displayNotification(
                      title: "Hello notification",
                      body: "Notification Recieved");
                  // notificationServices.scheduledNotification();
                },
                child: Icon(Icons.notification_add)),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
