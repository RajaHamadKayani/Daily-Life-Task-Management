import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../views/login_view/login_view.dart';

class SplashViewController extends GetxController {
  void goToNext(BuildContext context) {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }
}
