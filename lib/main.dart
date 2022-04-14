// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence_27_maret/controller/login_controller.dart';
import 'package:presence_27_maret/routes/app_pages.dart';
import 'controller/add_employe_controller.dart';
import 'controller/home_controller.dart';
import 'controller/page_index_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        name: 'SecondaryApp',
        options: const FirebaseOptions(
            appId: '1:405203550475:web:4d12ed0e1d52a05f24220e',
            apiKey: 'AIzaSyB_q3MP-PUmxASxg0hTuTjxdYmejF-hcXw',
            messagingSenderId: '405203550475',
            projectId: 'presenceapp-7b206'));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final addEmployeeController =
        Get.put(AddEmployeeController(), permanent: true);
    final homeController = Get.put(HomeController());
    final loginController = Get.put(LoginController());
    final pageIndexController = Get.put(PageIndexController());

    // final lupaPasswordController = Get.put(LupaPasswordController());
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Presence Application",
            initialRoute:
                (snapshot.data != null && snapshot.data!.emailVerified == true)
                    ? AppRoutes.HOME
                    : AppRoutes.LOGIN,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
