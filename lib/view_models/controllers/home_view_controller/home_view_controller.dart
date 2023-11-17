import 'package:daily_life_tasks_management/db/database_helper/database_helper.dart';
import 'package:daily_life_tasks_management/models/task_model/task_model.dart';
import 'package:daily_life_tasks_management/view_models/controllers/cron_controller/cron_controller.dart';
import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
import 'package:daily_life_tasks_management/views/home_view/home_view.dart';
import 'package:daily_life_tasks_management/views/widgets/text_field_widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/tzdata.dart' as tz;

class HomeViewController extends GetxController {
  HomeView homeView = HomeView();
  late Future<List<TaskModel>> showTasks;
  DatabaseHelper? databaseHelper = DatabaseHelper();
 

  loadData() async {
    showTasks = databaseHelper!.getData();
  }

 
}
