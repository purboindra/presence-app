// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/page_index_controller.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

import '../controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  final pageIndexController = Get.find<PageIndexController>();
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) {
          print(i);
          pageIndexController.changePage(i);
        },
      ),
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            String defaultImage =
                'https://ui-avatars.com/api/?name=${user["name"]}';
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          user["profile"] != null
                              ? user["prfoile"] != ''
                                  ? user["profile"]
                                  : defaultImage
                              : defaultImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "${user["name"].toString().toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${user["email"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () => Get.toNamed(
                    AppRoutes.UPDATE_PROFILE,
                    arguments: user,
                  ),
                  leading: Icon(Icons.person),
                  title: TextButton(
                    onPressed: () {},
                    child: Text("Update Profile"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.UPDATE_PASSWORD),
                    child: Text("Change Password"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (user["role"] == "admin")
                  ListTile(
                    leading: Icon(Icons.person),
                    title: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.ADD_PEGAWAI),
                      child: Text("Add Employee"),
                    ),
                  ),
                if (user["role"] == "admin")
                  SizedBox(
                    height: 20,
                  ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: TextButton(
                    onPressed: () => controller.logOut(),
                    child: Icon(Icons.logout),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Wrong"),
            );
          }
        },
      ),
    );
  }
}
