// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  final ImagePicker picker = ImagePicker();
  XFile? image;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
    } else {
      print('no image');
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "name": nameController.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref('$uid/profile.$ext').putFile(file);
          String urlImage =
              await storage.ref('$uid/profile.$ext').getDownloadURL();

          data.addAll({'profile': urlImage});
        }
        await firestore.collection("employee").doc(uid).update(data);
        image = null;
        Get.snackbar("Success", "Your profile has been updated!");
      } catch (e) {
        Get.snackbar('Something Wrong', "Couldn't update profile yet!");
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteProfile(String uid) async {
    try {
      await firestore.collection("employee").doc(uid).update({
        'profile': FieldValue.delete(),
      });
      Get.back();
    } catch (e) {
      Get.snackbar('Something Wrong', "Couldn't delete image profile!");
    } finally {
      update();
    }
  }
}
