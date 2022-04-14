// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/login_controller.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
          TextField(
            autocorrect: false,
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Obx(
            () => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.login();
                  }
                },
                child: controller.isLoading.isFalse
                    ? Text("Login")
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                // : loadingScaffold(),
                ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.LUPA_PASSWORD);
            },
            child: Text("Forget Password"),
          ),
        ],
      ),
    );
  }
}
