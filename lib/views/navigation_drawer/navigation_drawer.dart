import 'package:daily_life_tasks_management/views/add_task/add_task.dart';
import 'package:daily_life_tasks_management/views/alarm_screen/alarm_screen.dart';
import 'package:daily_life_tasks_management/views/google_map_permission/google_map_permission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyNavigationDrawer extends StatefulWidget {
  String? title;
  String? email;
  MyNavigationDrawer({super.key, this.email, this.title});

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  List<String> title = ["Live Location", "Charging module", "Add tasks"];
  List<Icon> icons = [
    const Icon(Icons.location_on),
    const Icon(Icons.charging_station),
    const Icon(Icons.task)
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: Text(widget.title ?? ""),
            accountEmail: Text(widget.email ?? ""),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  itemCount: title.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        child: GestureDetector(
                          onTap: () {
                            navToNext(context, index);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: ListTile(
                                leading: icons[index],
                                title: Text(title[index].toString()),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  navToNext(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.to(const GoogleMapPermission());
      case 1:
        Get.to( AlarmScreen());
      case 2:
        Get.to(const AddTask());
    }
  }
}
