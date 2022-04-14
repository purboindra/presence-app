// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/password_controller.dart';

class PasswordPage extends GetView<PasswordController> {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(PasswordController());
    return Scaffold(
      appBar: AppBar(
        title: Text("New Password"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.oldPasswordController,
            decoration: InputDecoration(
              labelText: "Old Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.newPasswordController,
            decoration: InputDecoration(
              labelText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () => controller.newPassword(),
            child: Text("New Password"),
          ),
        ],
      ),
    );
  }
}
