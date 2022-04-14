// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_27_maret/controller/home_controller.dart';
import 'package:presence_27_maret/controller/login_controller.dart';
import 'package:presence_27_maret/routes/app_pages.dart';

import '../controller/add_employe_controller.dart';
import '../controller/page_index_controller.dart';

class HomePage extends GetView<HomeController> {
  final loginController = Get.find<LoginController>();
  final addEmployeeController = Get.find<AddEmployeeController>();
  final pageIndexController = Get.find<PageIndexController>();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginC = Get.put(LoginController());

    final addEmployeeC = Get.put(AddEmployeeController());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 239),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: (int i) {
          pageIndexController.changePage(i);
        },
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
              return CustomScrollView(
                // ignore: prefer_const_literals_to_create_immutables
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.orange.withAlpha(10),
                    collapsedHeight: 80,
                    expandedHeight: 130,
                    pinned: true,
                    floating: true,
                    snap: true,
                    flexibleSpace: Container(
                      margin: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 223, 94, 25),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: user["prfole"] != null
                                    ? Image.network(user["profile"])
                                    : Image.asset(
                                        "assets/avatar.png",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  user["address"] != null
                                      ? "${user["address"]}"
                                      : "Tidak ada lokasi",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //
                    //
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffc36531),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${user["job"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${user["nip"]}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${user["name"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 228, 228, 228)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>(
                                      stream: controller.streamToday(),
                                      builder: (context, snapshotToday) {
                                        if (snapshotToday.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        Map<String, dynamic>? dataToday =
                                            snapshotToday.data?.data();

                                        if (snapshotToday.data!.data() !=
                                            null) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 235, 235, 235),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("Masuk"),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(dataToday!["masuk"] !=
                                                            null
                                                        ? DateFormat.jms()
                                                            .format(DateTime
                                                                .parse(dataToday[
                                                                        "masuk"]
                                                                    ['date']))
                                                        : "-"),
                                                  ],
                                                ),
                                                Container(
                                                  width: 2,
                                                  color: Colors.white,
                                                  height: 40,
                                                ),
                                                Column(
                                                  children: [
                                                    Text("Keluar"),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(dataToday["keluar"] !=
                                                            null
                                                        ? DateFormat.jms()
                                                            .format(DateTime
                                                                .parse(dataToday[
                                                                        "keluar"]
                                                                    ['date']))
                                                        : "-"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 5,
                                                  top: 10,
                                                ),
                                                height: 150,
                                                width: 250,

                                                child: Image.asset(
                                                  "assets/home2.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                // child: Center(
                                                //     child: Text('You haven\'t presence today!')),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "You haven't presence today!",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Color(0xff02435f),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Last presence",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextButton(
                                          onPressed: () => Get.toNamed(
                                              AppRoutes.ALL_PRESENCE),
                                          child: Text(
                                            "See more",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: controller.streamLastPresence(),
                                      builder: (context, snapshotPresence) {
                                        if (snapshotPresence.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshotPresence
                                                .data!.docs.isEmpty ||
                                            snapshotPresence.data == null) {
                                          return Column(
                                            children: [
                                              Container(
                                                height: 150,
                                                margin: EdgeInsets.only(),
                                                child: Image.asset(
                                                  "assets/home5.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                // child: Center(
                                                //     child: Text('You haven\'t presence today!')),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "There is nothing here!",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshotPresence
                                                  .data!.docs.length,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> data =
                                                    snapshotPresence
                                                        .data!.docs[index]
                                                        .data();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 20,
                                                  ),
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color.fromARGB(
                                                        255, 230, 230, 230),
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      onTap: () {
                                                        Get.toNamed(
                                                          AppRoutes
                                                              .DETAIL_PRESENCE,
                                                          arguments: data,
                                                        );
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: 15,
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text("Masuk"),
                                                                Text(DateFormat
                                                                        .yMMMEd()
                                                                    .format(DateTime
                                                                        .parse(data[
                                                                            'date']))),
                                                              ],
                                                            ),
                                                            Text(data["masuk"]?[
                                                                        "date"] ==
                                                                    null
                                                                ? "-"
                                                                : DateFormat
                                                                        .jms()
                                                                    .format(DateTime.parse(
                                                                        data["masuk"]
                                                                            ?[
                                                                            'date']))),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text("Keluar"),
                                                            Text(data["keluar"]
                                                                        ?[
                                                                        "date"] ==
                                                                    null
                                                                ? "-"
                                                                : DateFormat
                                                                        .jms()
                                                                    .format(DateTime.parse(
                                                                        data["keluar"]
                                                                            ?[
                                                                            'date']))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }
                                      }),
                                ],
                              ),
                            ),
                        childCount: 1),
                  )
                ],
              );
            }
            return Center(
              child: Text("Something  Wrong"),
            );
          }),
    );
  }
}

class DelegateClass extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
}
