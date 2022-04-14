// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isLoadingAddEmployee = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String date = DateTime.now().toIso8601String();

  Future<void> processAddEmployee() async {
    // print("object");
    if (passwordAdminController.text.isNotEmpty) {
      isLoadingAddEmployee.value = true;
      try {
        if (UserCredential != null) {
          String emailAdmin = auth.currentUser!.email!;
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passwordAdminController.text);

          UserCredential employeeCredential =
              await auth.createUserWithEmailAndPassword(
                  email: emailController.text, password: "password");
          if (employeeCredential != null) {
            String uid = employeeCredential.user!.uid;
            firestore.collection("employee").doc(uid).set({
              "nip": nipController.text,
              "name": nameController.text,
              "email": emailController.text,
              "job": jobController.text,
              "role": "Employee",
              "uid": uid,
              "createdAt": date,
            });

            await employeeCredential.user!.sendEmailVerification();

            print(employeeCredential);

            await auth.signOut();

            UserCredential userCredentialAdmin =
                await auth.signInWithEmailAndPassword(
                    email: emailAdmin, password: passwordAdminController.text);
            Get.back(); //close dialogue
            Get.back(); //back to  home
            Get.snackbar("Succes", "Succes added employee");
          }
        } else {
          print('error');
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        isLoadingAddEmployee.value = false;
        if (e.code == 'weak-password') {
          Get.snackbar("Something Wrong", "Your password is to week to use!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
              "Something Wrong", "That's employe is already have an account!");
        } else if (e.code == "wrong-password") {
          Get.snackbar("Something Wrong", "Coldn't login, wrong password");
        } else {
          isLoadingAddEmployee.value = false;
          Get.snackbar("Something Wrong", e.code);
        }
      } catch (e) {
        isLoadingAddEmployee.value = false;
        Get.snackbar("Something Wrong", "Cannot added the employe!");
      }

      Get.snackbar("Something Wrong", "Password must be filled");
    }
  }

  Future<void> addEmploye() async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = false;
      Get.defaultDialog(
        title: "Validate Admin",
        content: Column(
          children: [
            Text('Input your password for validate'),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordAdminController,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
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
              await processAddEmployee();
            },
            child: isLoading.isFalse ? Text("Add employee") : Text("Loading.."),
            //   if (isLoadingAddEmployee.value = false) {
            //     print("proses employee ${processAddEmployee}");
            //     processAddEmployee();
            //   }
            // },
            // child:
            //     isLoading.isFalse ? Text("Add Employee") : Text("Loading"),
          ),
        ],
      );
    } else {
      // isLoading.value = true;
      Get.snackbar("Something Wrong", "NIP, NAME, and EMAIL must be filled");
    }
  }
}
