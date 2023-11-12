import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
import 'package:daily_life_tasks_management/view_models/controllers/splash_view_controller/splash_view_controller.dart';
import 'package:daily_life_tasks_management/views/widgets/asset_image_widget/asset_image_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewController splashViewController = Get.put(SplashViewController());
  @override
  void initState() {
    super.initState();
    splashViewController.goToNext(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: ContainerWidget(
                  height: 300,
                  width: double.infinity,
                  widget: 
                  AssetImageWidget(
                    assetImage: "assets/images/habit_logo.jpg",
                    boxFit: BoxFit.contain,
                    
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              TextWidget(text: "Daily Life Task Management",textStyle: AppStyles.headlineMediumBlack,)
            ],
          ),
        ),
      ),
    );
  }
}
