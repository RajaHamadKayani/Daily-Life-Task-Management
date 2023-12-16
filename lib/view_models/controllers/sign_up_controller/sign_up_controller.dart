import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  void clearTextFields() {
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  registerUser(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      await _database.child("Users").child(credential.user!.uid).set({
        "name": nameController.value.text,
        "confirmPassword": confirmPasswordController.value.text,
        "phone": phoneController.value.text,
        "email": emailController.value.text,
        "password": passwordController.value.text
      });
      clearTextFields();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar("Sign Up", "The account already exists for that email.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.teal);
      }
    } catch (e) {
      print(e);
    }
  }
}
