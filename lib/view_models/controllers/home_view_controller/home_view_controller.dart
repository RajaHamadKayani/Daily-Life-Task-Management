import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:daily_life_tasks_management/views/home_view/home_view.dart';
import 'package:daily_life_tasks_management/views/widgets/text_field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewController extends GetxController {
  HomeView homeView = HomeView();
  late Future<List<TaskModel>> showTasks;
  DatabaseHelper? databaseHelper = DatabaseHelper();
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDescription =
      TextEditingController();
  TextEditingController textEditingControllerDateTime = TextEditingController();
  NotificationServies notificationServies = NotificationServies();

  loadData() async {
    showTasks = databaseHelper!.getData();
  }

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
                      controller: textEditingControllerDateTime,
                      hintText: "select deadline",
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          // ignore: use_build_context_synchronously
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (selectedTime != null) {
                            DateTime selectedDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );

                            textEditingControllerDateTime.text =
                                DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
                                    .format(selectedDateTime);
                          }
                        }
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

                                  showTasks = databaseHelper!.getData();
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
}
