// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/update_profile_controller.dart';

import '../controller/update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePasswordController = Get.put(UpdatePasswordController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Chang Password"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.currentPasswordController,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Current Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.newPasswordController,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.confirmNewPasswordController,
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Confirm New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.changePassword();
                  }
                },
                child: Text((controller.isLoading.isFalse)
                    ? "Change Password"
                    : "Loading.."),
              )),
        ],
      ),
    );
  }
}
