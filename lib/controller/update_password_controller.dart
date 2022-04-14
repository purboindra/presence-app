import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePassword() async {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currentPasswordController.text);

          await auth.currentUser!.updatePassword(newPasswordController.text);

          // await auth.signOut();

          // await auth.signInWithEmailAndPassword(
          //     email: emailUser, password: currentPasswordController.text);

          Get.offAllNamed(AppRoutes.LOGIN);

          Get.snackbar('Succes', "Your password has been changed!");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Something Wrong", "Your current password wrong!");
          } else {
            Get.snackbar("Something Wrong", e.code.toLowerCase());
          }
        } catch (e) {
          Get.snackbar(
              "Something Wrong", "Can't change password. Try again later!");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Something Wrong", "Wrong confirm your password");
      }
    } else {
      Get.snackbar("Something Wrong", "All field must be filled");
    }
  }
}
