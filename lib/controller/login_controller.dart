import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordController.text == "password") {
              Get.offAllNamed(AppRoutes.PASSWORD);
            } else {
              Get.offAllNamed(AppRoutes.HOME);
            }
          } else {
            isLoading.value = false;
            Get.defaultDialog(
              title: "User not verified",
              middleText: "You have to verified to your account first",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "Sent Email Verified Success!",
                        "We're have sent a verification email to your account. Please check your email!",
                      );
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar(
                        "Something Wrong",
                        "Couldn't send a verification email. You can sent a message to our customer service",
                      );
                    }
                  },
                  child: Text("Send Verified Email"),
                )
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.snackbar("Something Wrong", "User not found");
        } else if (e.code == 'wrong-password') {
          isLoading.value = false;
          Get.snackbar("Something Wrong", "Wrong password");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Something Wrong", "Couldn't login");
      }
    } else {
      // isLoading.value = false;
      Get.snackbar("Something Wrong", "Email and password must be filled");
    }
  }
}
