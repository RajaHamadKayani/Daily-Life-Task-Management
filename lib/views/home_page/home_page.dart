import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../view_models/notifcation_services_1/notification_services_1.dart';
import '../details_page/details_page.dart';
import '../navigation_drawer/navigation_drawer.dart';
import '../widgets/action_buttons.dart';
import '../widgets/custom_day_picker.dart';
import '../widgets/date_field.dart';
import '../widgets/header.dart';
import '../widgets/time_field.dart';

class HomePage extends StatefulWidget {
  String? name;
  String? email;
  HomePage({Key? key, this.email, this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices2 notificationServices2 = NotificationServices2();

  final int maxTitleLength = 60;
  TextEditingController _textEditingController =
      TextEditingController(text: "Business meeting");

  int segmentedControlGroupValue = 0;

  DateTime currentDate = DateTime.now();
  DateTime? eventDate;

  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? eventTime;

  Future<void> onCreate() async {
    await notificationServices2.showNotification(
      0,
      _textEditingController.text,
      "A new event has been created.",
      jsonEncode({
        "title": _textEditingController.text,
        "eventDate": DateFormat("EEEE, d MMM y").format(eventDate!),
        "eventTime": eventTime!.format(context),
      }),
    );

    await notificationServices2.scheduleNotification(
      1,
      _textEditingController.text,
      "Reminder for your scheduled event at ${eventTime!.format(context)}",
      eventDate!,
      eventTime!,
      jsonEncode({
        "title": _textEditingController.text,
        "eventDate": DateFormat("EEEE, d MMM y").format(eventDate!),
        "eventTime": eventTime!.format(context),
      }),
      getDateTimeComponents(),
    );

    resetForm();
  }

  Future<void> cancelAllNotifications() async {
    await notificationServices2.cancelAllNotifications();
  }

  void resetForm() {
    segmentedControlGroupValue = 0;
    eventDate = null;
    eventTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            )),
      ),
      drawer: MyNavigationDrawer(
        title: widget.name,
        email: widget.email,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(),
                    TextField(
                      controller: _textEditingController,
                      maxLength: maxTitleLength,
                      decoration: InputDecoration(
                        counterText: "",
                        suffix: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.grey[200],
                          ),
                          child: Text((maxTitleLength -
                                  _textEditingController.text.length)
                              .toString()),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    CupertinoSlidingSegmentedControl<int>(
                      onValueChanged: (value) {
                        if (value == 1) eventDate = null;
                        setState(() => segmentedControlGroupValue = value!);
                      },
                      groupValue: segmentedControlGroupValue,
                      padding: const EdgeInsets.all(4.0),
                      children: <int, Widget>{
                        0: Text("One time"),
                        1: Text("Daily"),
                        2: Text("Weekly")
                      },
                    ),
                    SizedBox(height: 24.0),
                    Text("Date & Time"),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: selectEventDate,
                      child: DateField(eventDate: eventDate),
                    ),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () async {
                        eventTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: currentTime.hour,
                            minute: currentTime.minute + 1,
                          ),
                        );
                        setState(() {});
                      },
                      child: TimeField(eventTime: eventTime),
                    ),
                    SizedBox(height: 20.0),
                    ActionButtons(
                      onCreate: onCreate,
                      onCancel: resetForm,
                    ),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () async {
                        await cancelAllNotifications();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("All notfications cancelled"),
                          ),
                        );
                      },
                      child: _buildCancelAllButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelAllButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.indigo[100],
      ),
      padding:const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cancel all the reminders",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Icon(Icons.clear),
        ],
      ),
    );
  }

  DateTimeComponents? getDateTimeComponents() {
    if (segmentedControlGroupValue == 1) {
      return DateTimeComponents.time;
    } else if (segmentedControlGroupValue == 2) {
      return DateTimeComponents.dayOfWeekAndTime;
    }
  }

  void selectEventDate() async {
    final today =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    if (segmentedControlGroupValue == 0) {
      eventDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: today,
        lastDate: new DateTime(currentDate.year + 10),
      );
      setState(() {});
    } else if (segmentedControlGroupValue == 1) {
      eventDate = today;
    } else if (segmentedControlGroupValue == 2) {
      CustomDayPicker(
        onDaySelect: (val) {
          print("$val: ${CustomDayPicker.weekdays[val]}");
          eventDate = today.add(
              Duration(days: (val - today.weekday + 1) % DateTime.daysPerWeek));
        },
      ).show(context);
    }
  }
  void scheduleNotificationsCheck() {
  AndroidAlarmManager.periodic(const Duration(minutes: 15), 0, checkNotifications);
}
void checkNotifications() async {
  // Check and show notifications if needed
  // You can use your existing notification logic here
}
}
