import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:daily_life_tasks_management/services/local_storage_priority_task/local_storage_priority_task.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../models/priority_task_model/priority_task_model.dart';

class BackgroundTasks{
  void callback() {
  // Check for tasks with deadlines
  _checkDeadlines();
}

Future<void> _checkDeadlines() async {
  final List<PriorityTaskModel> tasks = await TaskStorage.getTasks();
  final DateTime now = DateTime.now();

  for (final task in tasks) {
    if (task.deadline.isAfter(now) && task.deadline.difference(now).inMinutes <= 5) {
      // Play alarm if the deadline is within 5 minutes
      FlutterRingtonePlayer.playRingtone();
    }
  }
}

 void initializeBackgroundTasks() {
  AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, callback, wakeup: true);
}

}