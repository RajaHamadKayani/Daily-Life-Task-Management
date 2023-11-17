import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cron/cron.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CronController extends GetxController {
  Cron cron = Cron();

  cronMethod(dynamic dateTime, dynamic habitName) async {
    // Convert dateTime to Schedule type

    cron.schedule(Schedule.parse(dateTime), () async {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Task Monitoring',
          body: '$habitName has $dateTime deadline',
        ),
      );
    });
  }
}
