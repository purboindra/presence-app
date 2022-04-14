// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presence_27_maret/controller/all_presence_controller.dart';
import 'package:presence_27_maret/routes/app_pages.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AllPresencePage extends GetView<AllPresenceController> {
  const AllPresencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPresenceController = Get.put(AllPresenceController());
    return Scaffold(
      appBar: AppBar(
        title: Text("All Presence"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                padding: EdgeInsets.all(20),
                height: 400,
                child: SfDateRangePicker(
                  monthViewSettings:
                      DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (object) {
                    if (object != null) {
                      if ((object as PickerDateRange).endDate != null) {
                        controller.pickDate(object.startDate!, object.endDate!);
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.filter,
        ),
      ),
      body: GetBuilder<AllPresenceController>(
        builder: (c) => FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.futureAllPresence(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isNotEmpty &&
                snapshot.data?.docs.length != null) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        snapshot.data!.docs[index].data();
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 230, 230, 230),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Get.toNamed(AppRoutes.DETAIL_PRESENCE,
                                arguments: data);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 15,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Masuk"),
                                    Text(
                                      DateFormat.yMMMEd().format(
                                        DateTime.parse(
                                          data["masuk"]["date"],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(data["masuk"]?["date"] == null
                                    ? "-"
                                    : DateFormat.jms().format(DateTime.parse(
                                        data["masuk"]?['date']))),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Keluar"),
                                Text(data["keluar"]["date"] == null
                                    ? "-"
                                    : data["keluar"]["date"]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: Text("Oops.. You haven't presence data yet!"),
            );
          },
        ),
      ),
    );
  }
}
