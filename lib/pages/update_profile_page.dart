// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/update_profile_controller.dart';

class UpdateProfilePage extends GetView<UpdateProfileController> {
  final updateProfileController = Get.put(UpdateProfileController());
  final Map<String, dynamic> user = Get.arguments;
  UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nipController.text = user["nip"];
    controller.nameController.text = user["name"];
    controller.emailController.text = user["email"];

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.nipController,
            decoration: InputDecoration(
              labelText: "NIP",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            readOnly: true,
            autocorrect: false,
            controller: controller.emailController,
            decoration: InputDecoration(
              labelText: "EMAIL",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            controller: controller.nameController,
            decoration: InputDecoration(
              labelText: "NAME",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Photo Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.file(
                        File(c.image!.path),
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              user["profile"],
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteProfile(user['uid']);
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    } else {
                      return Text("No image");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Choose File"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.updateProfile(user["uid"]);
              }
            },
            child: Text("Update Profile"),
          ),
        ],
      ),
    );
  }
}
