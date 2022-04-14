import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

class PasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void newPassword() async {
    if (newPasswordController.text.isNotEmpty) {
      if (newPasswordController.text != 'password') {
        try {
          await auth.currentUser!.updatePassword(newPasswordController.text);
          String email = auth.currentUser!.email!;

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
              email: email, password: newPasswordController.text);

          Get.offAllNamed(AppRoutes.LOGIN);
        } on FirebaseAuthException catch (e) {
          if (e.code == "weak-password") {
            Get.snackbar("Something Wrong", "Your new password is to weak!");
          }
        } catch (e) {
          Get.snackbar("Something Wrong",
              "Cannot make a new password. Please, contact customer service");
        }
      } else if (newPasswordController.text == "password") {
        Get.snackbar('Something Wrong', "gagal");
      } else {
        if (oldPasswordController.text == "password") {
          Get.snackbar("Something Wrong", "Your old password is wrong");
        }
      }
      auth.currentUser!.updatePassword(newPasswordController.text);
    } else {
      Get.snackbar("Something Wrong", "New password must be filled");
    }
  }
}
