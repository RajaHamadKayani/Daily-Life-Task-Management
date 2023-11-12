import 'dart:async';

import 'package:daily_life_tasks_management/views/sign_up_view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashViewController extends GetxController {
  void goToNext(BuildContext context) {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Get.to(const SignUpView());
    });
  }
}
