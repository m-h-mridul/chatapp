// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, unused_import, non_constant_identifier_names, unused_local_variable, must_be_immutable

import 'package:chatapp/Service/UserList.dart';
import 'package:chatapp/controller/Usercontroller.dart';
import 'package:chatapp/model/userdata.dart';
import 'package:chatapp/screen/messageing/messageing_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import '../userinfo/CurrentUserInfo.dart';
import 'AlertDialog.dart';


class Alluser extends StatelessWidget {
  static String name = 'Alluser';
  Alluser({Key? key}) : super(key: key);

  // creat firebase instamce
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF009688),
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle),
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
              child: const Text('All Users',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )),
        body: SafeArea(
          child: GetX<Usercontroller>(
              init: Usercontroller(),
              builder: (control) {
                return (control.userName.isEmpty)
                    ? const Center(
                        child: Text('Loading...',
                            style: TextStyle(
                              fontSize: 16.0,
                            )))
                    : ListView.builder(
                        itemCount: control.userName.length,
                        // itemCount: data.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              // sent user name to messaheing ui
                              UserData.secondUserName =
                                  control.userName[i].user_name;
                              Navigator.pushNamed(context, Messageing_ui.name);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for first user alimgent position at the top
                                (i == 0)
                                    ? SizedBox(
                                        height: 8,
                                      )
                                    : SizedBox(
                                        height: 0.0,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        control.userName[i].user_name
                                            .toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: control.userName[i].activestatius
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
      ),
    );
  }
}
