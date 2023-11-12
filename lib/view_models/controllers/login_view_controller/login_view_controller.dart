import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<void> loginUser(BuildContext context) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Get.snackbar(
        "Sign In",
        "Login Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal,
      );

      // Fetch user data from the database after successful login
      DataSnapshot userDataSnapshot =
          await databaseReference.child("Users").child(credential.user!.uid).get();

      // Accessing specific fields from the user data
      String userEmail = userDataSnapshot.child("email").value.toString();
      String userName = userDataSnapshot.child("name").value.toString();
      String userPhone = userDataSnapshot.child("phone").value.toString();

      // Print or use the retrieved user data
      print('User Email: $userEmail');
      print('User Name: $userName');
      print('User Phone: $userPhone');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar(
          "Sign In",
          "No user found for that email",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.teal,
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar(
          "Sign In",
          "Incorrect email or password field",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.teal,
        );
      }
    }
  }
}
