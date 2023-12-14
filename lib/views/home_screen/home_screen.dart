// import 'package:daily_life_tasks_management/models/task/task.dart';
// import 'package:daily_life_tasks_management/view_models/controllers/task_controller/task_controller.dart';
// import 'package:daily_life_tasks_management/views/add_task/add_task.dart';
// import 'package:daily_life_tasks_management/views/navigation_drawer/navigation_drawer.dart';
// import 'package:daily_life_tasks_management/views/task_tile/task_tile.dart';
// import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
// import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// import '../../view_models/notification_services/notification_services.dart';

// class HomeScreen extends StatefulWidget {
//   String? name;
//   String? email;
//   HomeScreen({super.key, this.email, this.name});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Future<dynamic> dialogBox(BuildContext context, Task task) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 200,
//             width: 200,
//             child: AlertDialog(
//               title: const Text(
//                 "Delete Task!",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 22),
//               ),
//               content: const Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Are you sure want to delete Task?",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black,
//                         fontSize: 18),
//                   )
//                 ],
//               ),
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: const Center(
//                           child: Text(
//                             "Cancel",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         taskController.delete(task);
//                         taskController.fetchTasks();

//                         Get.back();
//                         Get.snackbar(
//                             "Deleted Task", "Task Deleted Successfuly");
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: const Center(
//                           child: Text(
//                             "Delete",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   loadData() async {
//     await taskController.fetchTasks(); // Add a method to fetch tasks
//     print("length of tasks ${taskController.taskList.length}");
//   }

//   NotificationServices notificationServices = NotificationServices();
//   TaskController taskController = Get.put(TaskController());
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     taskController.fetchTasks();

//     notificationServices.requestIOSPermissions();
//     notificationServices.initializeNotifications();
//     loadData();
//   }

//   DateTime selectedDateTime = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () {
//           Scaffold.of(context).openDrawer();
//         }, icon:const Icon(Icons.menu,color: Colors.black,)),
//       ),
//       drawer:MyNavigationDrawer(
//         title: widget.name,
//         email: widget.email,
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       // notificationServices.scheduledNotification(
//                       //     dateTime:
//                       //         DateTime.now().add(const Duration(seconds: 4)),
//                       //     title: "Task ",
//                       //     body: "Deadline");
//                     },
//                     child: const Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.black,
//                     )),
//                 const ClipRRect(
//                   child: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: CircleAvatar(
//                       backgroundImage:
//                           AssetImage("assets/images/habit_management_logo.png"),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       DateFormat.yMMMd().format(DateTime.now()),
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey,
//                           fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Today",
//                       style: GoogleFonts.montserrat(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25),
//                     )
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.to(const AddTask());
//                     taskController.fetchTasks();
//                   },
//                   child: ContainerWidget(
//                     height: 50,
//                     width: 120,
//                     color: 0xff2956f3,
//                     borderRadius: 12,
//                     widget: Center(
//                       child: Text(
//                         "+ Add Task",
//                         style: GoogleFonts.montserrat(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               child: DatePicker(
//                 DateTime.now(),
//                 initialSelectedDate: DateTime.now(),
//                 height: 100,
//                 selectionColor: Colors.grey,
//                 width: 50,
//                 onDateChange: (date) {
//                   setState(() {
//                     selectedDateTime = date;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             itemsList()
//           ],
//         ),
//       )),
//     );
//   }

//   itemsList() {
//     return Expanded(child: Obx(() {
//       return ListView.builder(
//           itemCount: taskController.taskList.length,
//           itemBuilder: (context, index) {
//             Task task = taskController.taskList[index];

//             // print(task.toJson());
//             if (task.repeat == 'Daily') {
//               print("Task start time: ${task.startTime}");
//               DateTime date = DateFormat.Hm().parse(task.startTime.toString());
//               var myTime = DateFormat("HH:mm").format(date);
//               print(myTime);
//               notificationServices.scheduledNotification(
//                   // int.parse(myTime.toString().split(":")[0]),
//                   // int.parse(myTime.toString().split(":")[1]),
//                   // task
//                   );

//               return AnimationConfiguration.staggeredList(
//                   position: index,
//                   child: SlideAnimation(
//                       child: FadeInAnimation(
//                           child: GestureDetector(
//                               onTap: () {
//                                 dialogBox(context, task);
//                               },
//                               child: TaskTile(task)))));
//             }
//             if (task.date == DateFormat.yMd().format(selectedDateTime)) {
//               return AnimationConfiguration.staggeredList(
//                   position: index,
//                   child: SlideAnimation(
//                       child: FadeInAnimation(
//                           child: GestureDetector(
//                     onTap: () {
//                       dialogBox(context, task);
//                     },
//                     child: TaskTile(task),
//                   ))));
//             } else {
//               return Container();
//             }
//           });
//     }));
//   }

//   bottomSheet(BuildContext context, Task task) {
//     Get.bottomSheet(Container(
//       padding: const EdgeInsets.only(top: 10),
//       height: task.isCompleted == 1
//           ? MediaQuery.of(context).size.height * 0.24
//           : MediaQuery.of(context).size.height * 0.36,
//       color: Colors.white,
//       child: Column(
//         children: [
//           Container(
//             height: 6,
//             width: 120,
//             decoration: BoxDecoration(color: Colors.grey[300]),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           task.isCompleted == 1
//               ? Container()
//               : bottomSheetContainer(
//                   context: context,
//                   color: Colors.blue,
//                   title: "Task Completed",
//                   onTap: () {
//                     taskController.markTheTaskCompleted(task.id!);
//                     taskController.fetchTasks();
//                     Get.back();
//                   }),
//           const SizedBox(
//             height: 10,
//           ),
//           bottomSheetContainer(
//               color: Colors.red,
//               title: "Delete Task",
//               context: context,
//               onTap: () {
//                 try {
//                   taskController.delete(task);

//                   print("Task Deleted successfully");
//                   Get.snackbar("Deletion",
//                       "Task ${task.title} has been deleted successfully",
//                       colorText: Colors.white, backgroundColor: Colors.blue);
//                   print("Task ${task.title} has been deleted successfully");
//                   taskController.fetchTasks();
//                 } catch (e) {
//                   print("error while deleting the task: ${e.toString()}");
//                 }
//                 Get.back();
//               }),
//           const SizedBox(
//             height: 20,
//           ),
//           bottomSheetContainer(
//               color: Colors.white,
//               title: "Close",
//               borderColor: 0xff000000,
//               borderWidth: 1,
//               textColor: 0xff000000,
//               context: context,
//               onTap: () {
//                 Get.back();
//               })
//         ],
//       ),
//     ));
//   }

//   bottomSheetContainer(
//       {required Color color,
//       required String title,
//       double? borderWidth,
//       int? borderColor,
//       int? textColor,
//       bool isClose = false,
//       required BuildContext context,
//       required Function onTap}) {
//     return GestureDetector(
//       onTap: () {
//         onTap;
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Container(
//           height: 50,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               border: Border.all(
//                   color: Color(borderColor ?? 0), width: borderWidth ?? 0),
//               color: color,
//               borderRadius: BorderRadius.circular(20)),
//           child: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                   color: Color(textColor ?? 0xffffffff),
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
