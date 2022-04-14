import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_27_maret/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int index) async {
    switch (index) {
      case 1:
        Map<String, dynamic> dataResponse = await determinePosition();
        if (dataResponse["error"] != true) {
          Position position = dataResponse["position"];
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String address =
              "${placeMarks[0].name}, ${placeMarks[0].subLocality}, ${placeMarks[0].locality}";
          await updatePosition(position, address);
          double distance = Geolocator.distanceBetween(
              6.3016795, -106.6483593, position.latitude, position.longitude);

          await presence(position, address, distance);
        } else {
          Get.snackbar("Something Wrong", dataResponse["message"]);
        }
        break;
      case 2:
        pageIndex.value = index;
        Get.offAllNamed(AppRoutes.PROFILE);
        break;
      default:
        pageIndex.value = index;
        Get.offAllNamed(AppRoutes.HOME);
    }
  }

  Future<void> presence(
      Position position, String address, double distance) async {
    String uid = auth.currentUser!.uid;
    CollectionReference<Map<String, dynamic>> collectionPresence =
        firestore.collection("employee").doc(uid).collection("presence");
    QuerySnapshot<Map<String, dynamic>> snapshotPresence =
        await collectionPresence.get();
    DateTime now = DateTime.now();
    String todayDocId = DateFormat.yMd().format(now).replaceAll("/", "-");

    String status = "Out of area";

    if (distance <= 200) {
      //in area/acceppted to presen
      status = "In of area";
    }

    if (snapshotPresence.docs.isEmpty) {
      await Get.defaultDialog(
        title: "Validate Presence",
        middleText: "Are you sure to presence attendence today?",
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              collectionPresence.doc(todayDocId).set({
                "date": now.toIso8601String(),
                "masuk": {
                  "date": now.toIso8601String(),
                  "lat": position.latitude,
                  "long": position.longitude,
                  "address": address,
                  "status": status,
                  "distance": distance,
                }
              });
              Get.back();
              Get.snackbar("Success", "You have ben presence!");
            },
            child: Text('Yes'),
          ),
        ],
      );
    } else {
      DocumentSnapshot<Map<String, dynamic>> todayDoc =
          await collectionPresence.doc(todayDocId).get();
      var user = firestore.collection("employee").doc(uid).get();
      if (todayDoc.exists == true) {
        //absen keluar
        Map<String, dynamic>? dataPresenceToday = todayDoc.data();
        if (dataPresenceToday!["keluar"] != null) {
        } else {
          //absen keluar
          await Get.defaultDialog(
            title: "Validate Presence",
            middleText: "Are you sure to presence attendence today?",
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await collectionPresence.doc(todayDocId).update({
                    "date": now.toIso8601String(),
                    "keluar": {
                      "date": now.toIso8601String(),
                      "lat": position.latitude,
                      "long": position.longitude,
                      "address": address,
                      "status": status,
                      "distance": distance,
                    }
                  });
                  Get.back();
                },
                child: Text('Yes'),
              ),
            ],
          );
        }
      } else {
        await Get.defaultDialog(
          title: "Validate Presence",
          middleText: "Are you sure to presence attendence today?",
          actions: [
            OutlinedButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await collectionPresence.doc(todayDocId).set({
                  "date": now.toIso8601String(),
                  "masuk": {
                    "date": now.toIso8601String(),
                    "lat": position.latitude,
                    "long": position.longitude,
                    "address": address,
                    "status": status,
                    "distance": distance,
                  }
                });
                Get.back();
                Get.snackbar("Success", "You have ben presence!");
              },
              child: Text('Yes'),
            ),
          ],
        );
        //absen masuk
        print("masuk");
      }
      Get.snackbar("Halo ${""}", "Have a nice day!");
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    String uid = auth.currentUser!.uid;
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    await firestore.collection("employee").doc(uid).update({
      "position": {
        "lat": position.latitude,
        "long": position.longitude,
      },
      "address": address,
    });
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message": "Can't using GPS on this device",
        "error": true,
      };
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message": "Allow acces to using GPS is denied",
          "error": true,
        };
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Your device setting cannot to access the GPS. Change your device setting",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return {
      "position": position,
      "message": "Success get position device",
      "error": false,
    };
  }
}
