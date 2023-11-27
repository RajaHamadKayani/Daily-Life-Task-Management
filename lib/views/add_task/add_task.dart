import 'package:daily_life_tasks_management/views/widgets/add_task_field_widget/add_task_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerNote = TextEditingController();
  TextEditingController textEditingControllerDate = TextEditingController();
  TextEditingController textEditingControllerStartTime =
      TextEditingController();
  TextEditingController textEditingControllerEndTime = TextEditingController();
  TextEditingController textEditingControllerRemind = TextEditingController();
  TextEditingController textEditingControllerRepeat = TextEditingController();

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
                      onPressed: () {},
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
                hintTextl: "Enter Date here",
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
                        suffixIcon: Icons.access_time_filled_outlined,
                        controller: textEditingControllerStartTime,
                        hintTextl: "Enter Start Date",
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 1,
                      child: AddTaskFieldWidget(
                        title: "End Time",
                        suffixIcon: Icons.access_time_filled_outlined,
                        controller: textEditingControllerEndTime,
                        hintTextl: "Enter End Date",
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerRemind,
                containerWidth: double.infinity,
                hintTextl: "Enter Remind Time",
                suffixIcon: Icons.arrow_drop_down,
                title: "Remind",
              ),
              const SizedBox(
                height: 20,
              ),
              AddTaskFieldWidget(
                controller: textEditingControllerRepeat,
                containerWidth: double.infinity,
                hintTextl: "Enter Repeat Time",
                suffixIcon: Icons.arrow_drop_down,
                title: "Repeat",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
