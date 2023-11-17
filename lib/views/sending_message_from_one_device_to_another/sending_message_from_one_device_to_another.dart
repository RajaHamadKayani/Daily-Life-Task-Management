// import 'dart:convert';

// import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
// import 'package:daily_life_tasks_management/view_models/controllers/home_view_controller/home_view_controller.dart';
// import 'package:daily_life_tasks_management/view_models/notification_services/notification_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class SendingMessageFromOneDeviceToAnother extends StatefulWidget {
//   const SendingMessageFromOneDeviceToAnother({super.key});

//   @override
//   State<SendingMessageFromOneDeviceToAnother> createState() =>
//       _SendingMessageFromOneDeviceToAnotherState();
// }

// class _SendingMessageFromOneDeviceToAnotherState
//     extends State<SendingMessageFromOneDeviceToAnother> {
//   HomeViewController homeController = Get.put(HomeViewController());
//   NotificationServies notificationServies = NotificationServies();
//   @override
//   void initState() {
//     super.initState();
//     homeController.loadData();
//     notificationServies.requestNotificationsPermissions();
//     notificationServies.firebaseInit(context);
//     notificationServies.setUpInteractMessage(context);

//     notificationServies.getDeviceToken().then((value) {
//       print("Device notification token is:");
//       print(value.toString());
//       notificationServies.refereshToken();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             notificationServies.getDeviceToken().then((value) async {
//               var data = {
//                 "priority": "high",
//                 "to": value.toString(),
//                 "notification": {"title": "Task Alert", "body": "Task Alert!"},
//                 "data": {"key": "message", "id": "123456"}
//               };
//               await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
//                   body: jsonEncode(data),
//                   headers: {
//                     "Content-Type": "application/json ; charset=UTF-8",
//                     "Authorization":"key=AAAAIm8aJv4:APA91bGvodHU-uPXlwByN7v1sXSZRwHgoNpgboe2CGpayKrFbfeKf3GAUTDCQeZWPn88qYimY5FwO4UHoLcywooZc6vLP6N2_YiUMcyWtWRn5UtfSjqogPOtRsOQmgawbYWgSd6GJcdB"
//                   });
//             });
//           },
//           child: Text(
//             "Send Notifications",
//             style: AppStyles.headlineMediumBlack,
//           ),
//         ),
//       ),
//     );
//   }
// }
