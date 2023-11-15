import 'package:daily_life_tasks_management/utils/app_style/app_styles.dart';
import 'package:daily_life_tasks_management/view_models/controllers/sign_up_controller/sign_up_controller.dart';
import 'package:daily_life_tasks_management/views/login_view/login_view.dart';
import 'package:daily_life_tasks_management/views/widgets/container_widget/container_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_field_widget/text_field_widget.dart';
import 'package:daily_life_tasks_management/views/widgets/text_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController signUpController = Get.put(SignUpController());
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
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: "SignUp",
                textStyle: AppStyles.headlineMediumBlack,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldWidget(
                controller: signUpController.emailController,
                controllerStyle: AppStyles.headlineMediumBlack,
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
                controller: signUpController.passwordController,
                controllerStyle: AppStyles.headlineMediumBlack,
                hintText: "Enter password",
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
                controller: signUpController.confirmPasswordController,
                controllerStyle: AppStyles.headlineMediumBlack,
                hintText: "Confirm Password",
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
                controller: signUpController.nameController,
                controllerStyle: AppStyles.headlineMediumBlack,
                hintText: "Enter your name",
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
                controller: signUpController.phoneController,
                controllerStyle: AppStyles.headlineMediumBlack,
                hintText: "Enter your phone",
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
                        signUpController.registerUser(context);
                      },
                      child: ContainerWidget(
                        height: 50,
                        width: double.infinity,
                        color: 0xff00bfaf,
                        borderRadius: 25,
                        widget: Center(
                          child: TextWidget(
                            text: "Sign Up",
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
                          Get.to(const LoginView());
                        },
                        child: TextWidget(
                          text: "Already have an account? Sign In",
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
