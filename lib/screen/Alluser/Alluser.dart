// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, unused_import, non_constant_identifier_names, unused_local_variable, must_be_immutable

import 'package:flutter/services.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/Service/UserList.dart';
import 'package:potro/controller/Usercontroller.dart';
import 'package:potro/model/userdata.dart';
import 'package:potro/screen/messageing/messageing_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import '../../Service/filesentdatabase.dart';
import '../../helper/media.dart';
import '../profile/profile.dart';
import 'AlertDialog.dart';

class Alluser extends StatelessWidget {
  static String name = 'Alluser';
  Alluser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQuerypage.init(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFFFFFF),
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appbarWidget(context),
        body: GetX<Usercontroller>(
            init: Usercontroller(),
            builder: (control) {
              return (control.users.isEmpty)
                  ? const Center(
                      child: Text('Loading...',
                          style: TextStyle(
                            fontSize: 16.0,
                          )))
                  : ListView.builder(
                      itemCount: control.users.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            // sent user name to messaheing ui
                            UserData.secondUserName = control.users[i].userName;
                            var temp = DateFormat('dd(EE)-M hh:mm a')
                                .format(control.users[i].lastactive.toDate());

                            UserData.secondUserActiveTime =
                                control.users[i].activestatius
                                    ? "Active Now"
                                    : temp;
                            UserData.secondUserImage.value =
                                control.users[i].imageLink;

                            Navigator.pushNamed(context, Messageing_ui.name);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  MediaQuerypage.smallSizeWidth! * .01,
                                  MediaQuerypage.smallSizeHeight! * .5,
                                  MediaQuerypage.smallSizeWidth! * 3,
                                  MediaQuerypage.smallSizeHeight! * .5,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Obx(
                                        () => imageview(
                                            control.users[i].imageLink),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          control.users[i].userName.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Obx(
                                          () => Text(
                                            control.users[i].lastMessageUser
                                                    .isEmpty
                                                ? "Start conversation"
                                                : ' find data ',

                                            // control.users[i]
                                            //     .lastMessageUser[0].text
                                            //     .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.circle,
                                      color: control.users[i].activestatius
                                          ? Colors.green
                                          : Colors.black12,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2.0,
                              )
                            ],
                          ),
                        );
                      },
                    );
            }),
      ),
    );
  }

  AppBar appbarWidget(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF009688),
        actions: [
          IconButton(
            icon: Obx(() => imageview(UserData.firstUserImage.value)),
            iconSize: 30,
            onPressed: () {
              // user info
              Navigator.pushNamed(context, UserProfile.name);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 30,
            onPressed: () {
              showAlertDialog(context);
            },
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text('Patro',
              style: TextStyle(
                color: Colors.white,
              )),
        ));
  }

  imageview(String userUid) {
    return CircleAvatar(
      backgroundColor: Colors.white70,
      backgroundImage: NetworkImage(userUid),
    );
  }
}
