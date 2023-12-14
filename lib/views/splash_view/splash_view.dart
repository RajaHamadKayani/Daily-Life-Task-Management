import 'package:daily_life_tasks_management/view_models/controllers/splash_view_controller/splash_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  SplashViewController splashViewController = SplashViewController();
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    splashViewController.goToNext(context);
    animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/json/splash_logo.json",
              controller: animationController,
              onLoaded: (composite) {
                animationController.duration = composite.duration;
                animationController.repeat;
              },
            ),
            const SizedBox(height: 20),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Daily Life ",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              TextSpan(
                  text: "Task Monitoring",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
            ]))
          ],
        ),
      )),
    );
  }
}
