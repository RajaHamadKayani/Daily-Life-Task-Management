import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
import 'package:daily_life_tasks_management/view_models/controllers/cron_controller/cron_controller.dart';
import 'package:daily_life_tasks_management/view_models/controllers/home_view_controller/home_view_controller.dart';
import 'package:daily_life_tasks_management/view_models/notifcation_services_1/notification_services_1.dart';
import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:daily_life_tasks_management/views/widgets/text_field_widget/text_field_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/browser.dart' as tz;

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  String? userName;
  HomeView({super.key, this.userName});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDescription =
      TextEditingController();
  TextEditingController textEditingControllerDate = TextEditingController();
  NotificationServies notificationServies = NotificationServies();
  CronController controller = Get.put(CronController());
  dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Note"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                        borderRadius: 25,
                        borderWidth: 2,
                        color: 0xff000000,
                        height: 40,
                        width: double.infinity,
                        controller: textEditingControllerTitle,
                        hintText: "Enter Task Title"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        borderRadius: 25,
                        borderWidth: 2,
                        color: 0xff000000,
                        height: 40,
                        width: double.infinity,
                        controller: textEditingControllerDescription,
                        hintText: "Enter task description"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      borderRadius: 25,
                      borderWidth: 2,
                      color: 0xff000000,
                      height: 40,
                      width: double.infinity,
                      controller: textEditingControllerDate,
                      hintText: "select deadline",
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2095),
                        );

                        if (selectedDate == null) {
                          return;
                        }
                        setState(() {
                          currentDateTime = selectedDate;
                          textEditingControllerDate.text =
                              "${currentDateTime.year}/${currentDateTime.currentDateTime.month}/${currentDateTime.day}";
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 70,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              try {
                                DateTime parsedDateTime =
                                    DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(
                                        textEditingControllerDateTime
                                            .value.text);
                                notificationServies.firebaseInit(
                                  context,
                                  textEditingControllerTitle.value.text,
                                  parsedDateTime,
                                );

                                databaseHelper!
                                    .insertData(TaskModel(
                                  description: textEditingControllerDescription
                                      .value.text,
                                  dateTime: parsedDateTime,
                                  title: textEditingControllerTitle.value.text,
                                ))
                                    .then((value) {
                                  print("values added");
                                  print("title is ${value.title}");

                                  homeController.showTasks =
                                      databaseHelper!.getData();
                                }).onError((error, stackTrace) {
                                  print(error.toString());
                                });
                                Navigator.pop(context);
                              } catch (e) {
                                print("Error parsing date: $e");
                                // Provide user-friendly error message
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "Error: Invalid date format. Please enter a valid date.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                                // Schedule the notification
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  dynamic title;
  // ignore: unused_field
  static dynamic dateTime;
  dynamic currentDateTime = DateTime.now();
  NotificationServices1 notificationServices1 = NotificationServices1();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  DatabaseHelper databaseHelper = DatabaseHelper();
  HomeViewController homeController = Get.put(HomeViewController());
  // void initLocalNotificationPlugin(BuildContext context) async {
  //   // this is for initializing the notifications for andoid and ios devices
  //   var androidInitializationSettings =
  //       const AndroidInitializationSettings("@mipmap/ic_launcher.png");
  //   var iosInitializationSettings = const DarwinInitializationSettings();
  //   var initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse: (payload) {});
  // }

  // Initialize the local notifications plugin

  @override
  void initState() {
    super.initState();
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher.png");
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    homeController.loadData();
  }

  void showNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            "Task Monitoring Notifcation", "Task Alert",
            priority: Priority.high,
            importance: Importance.high,
            channelDescription: "Your channel description",
            ticker: "ticker");
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    flutterLocalNotificationsPlugin.show(
        001, title, dateTime, notificationDetails);
    tz.initializeTimeZones();
    // ignore: unused_local_variable
    final tz.TZDateTime scheduale =
        tz.TZDateTime.from(currentDateTime, tz.local);
    flutterLocalNotificationsPlugin.zonedSchedule(
        001, title, dateTime, scheduale, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
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
              dialog(context);
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
                ElevatedButton(
                    onPressed: showNotification, child: Text("Show")),
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
                                title = snaphot.data![index].title;
                                dateTime = snaphot.data![index].dateTime;
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
                                  child: GestureDetector(
                                    onTap: () {
                                      notificationServices1
                                          .schedualeNotification(
                                              snaphot.data![index].title,
                                              snaphot.data![index].dateTime
                                                  .toString()
                                                  .toString());
                                      print("Card is clicked");
                                    },
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
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          0.6),
                                              child: Text(
                                                snaphot
                                                    .data![index].description,
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
