// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/lupa_password_controller.dart';

class LupaPassword extends GetView<LupaPasswordController> {
  const LupaPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lupaPasswordController = Get.put(LupaPasswordController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (controller.isLoading.isFalse) {
                  controller.sendEmail();
                }
                // else {
                //   loadingScaffold();
                // }
              },
              child: controller.isLoading.isFalse
                  ? Text("Send Reset Password")
                  : Text("Loading.."),
              // : loadingScaffold(),
            ),
          ),
        ],
      ),
    );
  }
}
