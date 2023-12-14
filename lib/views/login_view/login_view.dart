import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
import 'package:daily_life_tasks_management/view_models/controllers/login_view_controller/login_view_controller.dart';
import 'package:daily_life_tasks_management/views/sign_up_view/sign_up_view.dart';
import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_field_widget/text_field_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  bool isValide(BuildContext context) {
    if (loginViewController.emailController.value.text.isEmpty) {
      Get.snackbar("Login User", "Email Field can not be empty",
          colorText: Colors.white, backgroundColor: Colors.teal,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } else if (loginViewController.passwordController.value.text.isEmpty) {
      Get.snackbar("Login User", "Password Field can not be empty",
          colorText: Colors.white, backgroundColor: Colors.teal,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } else {
      return true;
    }
  }

  late AnimationController animationController;
  late LoginViewController loginViewController = Get.put(LoginViewController());
   
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);
      

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: TextWidget(
              text: "Daily Life Task Monitoring",
              textStyle: AppStyles.headlineBoldWhite,
            ),
          ),
          backgroundColor: AppStyles.whiteColor,
          body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset("assets/json/login_logo_1.json",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        controller: animationController,
                        repeat: true, onLoaded: (composite) {
                      animationController.duration = composite.duration;
                      animationController.repeat();
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: "Sign In",
                    textStyle: AppStyles.headlineMediumBlack,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldWidget(
                    controller:loginViewController.emailController,
                    hintText: "Enter email",
                    height: 50,
                    width: double.infinity,
                    borderRadius: 25,
                    borderWidth: 2,
                    color: 0xff000000,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller:loginViewController. passwordController,
                    hintText: "Enter password",
                    height: 50,
                    width: double.infinity,
                    borderRadius: 25,
                    borderWidth: 2,
                    color: 0xff000000,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            loginViewController.loginUser(context);
                            if (!isValide(context)) {
                              return;
                            }
                          },
                          child: ContainerWidget(
                            height: 50,
                            width: double.infinity,
                            color: 0xff00bfaf,
                            borderRadius: 25,
                            widget: Center(
                              child: TextWidget(
                                text: "Sign In",
                                textStyle: AppStyles.headlineMediumBlack,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpView()));

                          },
                          child: TextWidget(
                            text: "Not Registered yet? Sign Up",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
