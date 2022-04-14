// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controller/detail_presence_controller.dart';

class DetailPresencePage extends GetView<DetailController> {
  final Map<String, dynamic> data = Get.arguments;
  DetailPresencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Presence"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    DateFormat.yMMMMEEEEd().format(
                      DateTime.parse(data['date']),
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Masuk",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Jam: ${DateFormat.jms().format(
                    DateTime.parse(data['masuk']!["date"]),
                  )}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Posisi: ${data["masuk"]?["lat"]}, ${data["masuk"]?["lat"]} ",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Distance: ${data["masuk"]?["distance"].toString().split(".").first} meters",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Address: ${data["masuk"]?["address"]}",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Status: ${data["masuk"]["status"]} ",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Keluar",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data["keluar"]?["date"] == null
                      ? "Jam: -"
                      : "Jam: ${DateFormat.jms().format(
                          DateTime.parse(data['keluar']!["date"]),
                        )}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data["keluar"]?["lat"] == null &&
                          data["keluar"]?["lat"] == null
                      ? "Posisi: -"
                      : "Posisi: ${data["keluar"]["lat"]}, ${data["keluar"]["long"]}",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data['keluar']?["distance"] == null
                      ? "Distance: -"
                      : "Distance: ${data["keluar"]?["distance"].toString().split(".").first}",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data['keluar']?["address"] == null
                      ? "Address: -"
                      : "Address: ${data["keluar"]?["address"]}",
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  data["keluar"]?["status"] == null
                      ? "Status: -"
                      : "Status: ${data["status"]} ",
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 220, 220),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
