// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_employe_controller.dart';

class PegawaiPage extends GetView<AddEmployeeController> {
  const PegawaiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employe"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
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
          TextField(
            autocorrect: false,
            controller: controller.jobController,
            decoration: InputDecoration(
              labelText: "JOB",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
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
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                print(" controller add employee ${controller.addEmploye()}");
                await controller.addEmploye();
              }
            },
            child: controller.isLoading.isFalse
                ? Text("Add Employe")
                : Text("Loading.."),
          ),
        ],
      ),
    );
  }
}
