import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailController.text);
        Get.snackbar("Success", "Seccess sending a request reset email!");
        Get.back();
      } catch (e) {
        Get.snackbar(
            "Sometwhing Wrong", "Can't sending a request reset email!");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
