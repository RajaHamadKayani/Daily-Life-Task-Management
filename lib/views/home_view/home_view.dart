import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
import 'package:daily_life_tasks_management/view_models/controllers/home_view_controller/home_view_controller.dart';
import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:daily_life_tasks_management/views/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  String? userName;
  HomeView({super.key, this.userName});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationServies notificationServies = NotificationServies();
  DatabaseHelper databaseHelper = DatabaseHelper();
  HomeViewController homeController = Get.put(HomeViewController());
  void initLocalNotificationPlugin(BuildContext context) async {
    // this is for initializing the notifications for andoid and ios devices
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher.png");
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {});
  }

  // Initialize the local notifications plugin

  @override
  void initState() {
    super.initState();
    homeController.loadData();
    initLocalNotificationPlugin(context);
    notificationServies.requestNotificationsPermissions();
    notificationServies.firebaseInit(context);
    notificationServies.setUpInteractMessage(context);

    notificationServies.getDeviceToken().then((value) {
      print("Device notification token is:");
      print(value.toString());
      notificationServies.refereshToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: TextWidget(
              text: "Home Screen",
              textStyle: AppStyles.headlineBoldWhite,
            ),
            backgroundColor: Colors.teal,
          ),
          backgroundColor: AppStyles.whiteColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () {
              homeController.dialog(context);
            },
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text:
                      "${widget.userName} create, update and delete your daily tasks",
                  textStyle: AppStyles.headlineBold,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: homeController.showTasks,
                      builder:
                          (context, AsyncSnapshot<List<TaskModel>> snaphot) {
                        if (snaphot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: snaphot.data?.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  background: const SizedBox(
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      databaseHelper.deleteNote(snaphot
                                          .data![index]
                                          .id!); // it will access the delete method of the database helper to delete the particular note from the database
                                      homeController.showTasks = databaseHelper
                                          .getData(); // it will refresh the database and assign the list of the data in the database to showNotes list
                                      snaphot.data!
                                          .remove(snaphot.data![index]);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.teal,
                                              content: Text(
                                                "Task ${snaphot.data![index].id!} has been deleted from the notes list",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ))); // it will remove the widget from the screen of the list item of which we deleted from the database
                                    });
                                  },
                                  key: ValueKey<int>(snaphot.data![index].id!),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(snaphot.data![index].title),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    0.6),
                                            child: Text(
                                              snaphot.data![index].description,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Text(snaphot.data![index].dateTime
                                              .toString())
                                        ],
                                      ),
                                      leading: Text(
                                          snaphot.data![index].id.toString()),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }
}
