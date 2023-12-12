import 'package:daily_life_tasks_management/models/task/task.dart';
import 'package:daily_life_tasks_management/view_models/controllers/task_controller/task_controller.dart';
import 'package:daily_life_tasks_management/views/widgets/add_task_field_widget/add_task_field_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../db/DbHelper/dbHelper.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TaskController taskController = Get.put(TaskController());
  List<int> remindedList = [5, 10, 15, 20, 25];
  int initialSelectedColorIndex = 0;
  int initialRemind = 5;
  List<String> repeatTime = ["None", "Daily", "Weekly", "Monthly"];
  String initialRepeat = "None";
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerNote = TextEditingController();
  TextEditingController textEditingControllerDate = TextEditingController();
  TextEditingController textEditingControllerStartTime =
      TextEditingController();
  TextEditingController textEditingControllerEndTime = TextEditingController();
  TextEditingController textEditingControllerRemind = TextEditingController();
  TextEditingController textEditingControllerRepeat = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String endTime = "09:30 PM";
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  const ClipRRect(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/images/habit_management_logo.png"),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Add Tasks",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerTitle,
                containerWidth: double.infinity,
                hintTextl: "Enter title here",
                title: "Title",
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerNote,
                containerWidth: double.infinity,
                hintTextl: "Enter note here",
                title: "Note",
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerDate,
                containerWidth: double.infinity,
                suffixWidget: GestureDetector(
                  onTap: () {
                    getDateFromUser();
                  },
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
                hintTextl: DateFormat.yMd().format(selectedDate),
                title: "Date",
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: AddTaskFieldWidget(
                        title: "Start Time",
                        suffixWidget: GestureDetector(
                          onTap: () {
                            getTimeFromUser(isStartTime: true);
                          },
                          child: const Icon(Icons.access_time_filled_outlined),
                        ),
                        controller: textEditingControllerStartTime,
                        hintTextl: startTime,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 1,
                      child: AddTaskFieldWidget(
                        title: "End Time",
                        suffixWidget: GestureDetector(
                          onTap: () {
                            getTimeFromUser(isStartTime: false);
                          },
                          child: const Icon(Icons.access_time_filled_outlined),
                        ),
                        controller: textEditingControllerEndTime,
                        hintTextl: endTime,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerRemind,
                containerWidth: double.infinity,
                hintTextl: "$initialRemind minutes early",
                suffixWidget: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        initialRemind = int.parse(value!);
                      });
                    },
                    items:
                        remindedList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList()),
                title: "Remind",
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerRepeat,
                containerWidth: double.infinity,
                hintTextl: "$initialRepeat",
                suffixWidget: DropdownButton(
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      initialRepeat = value!;
                    });
                  },
                  items:
                      repeatTime.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      child: Text(value.toString()),
                      value: value.toString(),
                    );
                  }).toList(),
                ),
                title: "Repeat",
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Color",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        children: List<Widget>.generate(4, (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  initialSelectedColorIndex = index;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: index == 0
                                    ? Colors.red
                                    : index == 1
                                        ? Colors.blue
                                        : index==2?Colors.yellow:Colors.green,
                                child: Center(
                                  child: initialSelectedColorIndex == index
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.black,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      validations();
                      await DbHelper.initDb();
                      await addDataToDatabase();
                          taskController.fetchTasks();

                    },
                    child: ContainerWidget(
                      height: 50,
                      width: 120,
                      color: 0xff2956f3,
                      borderRadius: 12,
                      widget: Center(
                        child: Text(
                          "Create Task",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  getDateFromUser() async {
    DateTime? pickedDateFromUser = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (pickedDateFromUser != null) {
      setState(() {
        selectedDate = pickedDateFromUser;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          dismissDirection: DismissDirection.up,
          content: Text(
            "Something went wrong",
            style: GoogleFonts.poppins(color: Colors.white),
          )));
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await pickedTimeByUser();
    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Went worng");
    } else if (isStartTime == true) {
      setState(() {
        startTime = formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = formattedTime;
      });
    }
  }

  pickedTimeByUser() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1].split(" ")[0])));
  }

  validations() {
    if (textEditingControllerNote.text.isNotEmpty &&
        textEditingControllerTitle.text.isNotEmpty) {
      Get.back();
    } else if (textEditingControllerNote.text.isEmpty ||
        textEditingControllerTitle.text.isEmpty) {
      Get.snackbar("Required", "All fields should be filled",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          icon: const Icon(
            Icons.warning,
            color: Colors.grey,
          ));
    }
  }

  addDataToDatabase() async {
    int value = await taskController.addDataToTaskModel(Task(
        note: textEditingControllerNote.value.text,
        remind: initialRemind,
        repeat: initialRepeat,
        title: textEditingControllerTitle.value.text,
        date: DateFormat.yMd().format(selectedDate),
        endTime: endTime,
        startTime: startTime,
        color: initialSelectedColorIndex,
        isCompleted: 0));
    print("id of the inserted row is $value");
    
  }
}
