import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../../models/priority_task_model/priority_task_model.dart';

void checkAndTriggerAlarms(List<PriorityTaskModel> tasks) {
  final DateTime now = DateTime.now();

  for (PriorityTaskModel task in tasks) {
    if (task.deadline.isAfter(now)) {
      final Duration difference = task.deadline.difference(now);

      // Trigger alarm if the deadline is within a certain threshold
      if (difference.inMinutes <= 5) {
        FlutterRingtonePlayer.playRingtone();
      }
    }
  }
}
