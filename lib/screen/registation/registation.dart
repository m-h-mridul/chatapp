// ignore_for_file: unnecessary_new, unused_local_variable, unnecessary_null_comparison, non_constant_identifier_names, avoid_print, must_be_immutable

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:potro/model/userdata.dart';
import 'package:potro/screen/Alluser/Alluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/fIlemanagemet.dart';
import '../../helper/media.dart';

class Registation extends StatelessWidget {
  Registation({Key? key}) : super(key: key);

  ///firebase auth
  final _auth = FirebaseAuth.instance;
  static String name = "Registation";
  // text field variable
  TextEditingController c_name = new TextEditingController();
  TextEditingController c_email = new TextEditingController();
  TextEditingController c_password = new TextEditingController();
  // controller
  final FileManagement _fileManagement = FileManagement();

  @override
  Widget build(BuildContext context) {
    // button style
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 20));
    // border radius
    const BorderRadius borderRadius = BorderRadius.all(
      Radius.circular(12),
    );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // icon and name  of  the app
                  InkWell(
                      onTap: () {
                        _fileManagement.imagegetfromGeleary(context);
                      },
                      child: Obx(() => _fileManagement.imagepath.value != ''
                          ? Image.file(
                              File(_fileManagement.imagepath.value),
                              width: MediaQuerypage.screenWidth! / 2,
                              height: MediaQuerypage.screenHeight! / 4,
                            )
                          : Image(
                              fit: BoxFit.fill,
                              width: MediaQuerypage.screenWidth! / 2,
                              height: MediaQuerypage.screenHeight! / 4,
                              color: const Color(0xFF009688),
                              image: const AssetImage(
                                'assets/user.png',
                              ),
                            ))),

                  // textfield about the
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 12.0),
                    child: TextField(
                      controller: c_name,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: borderRadius,
                        ),
                        labelText: 'Name',
                        hintText: 'Enter your name',
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 12.0),
                    child: TextField(
                      controller: c_email,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: borderRadius,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 12.0),
                    child: TextField(
                      controller: c_password,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: borderRadius,
                        ),
                        labelText: 'Password',
                        hintText: 'Password length might be 6',
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuerypage.screenHeight! / 14,
                    width: MediaQuerypage.screenWidth!,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () async {
                        print("registation working .....");
                        try {
                          // creat an acccout in firebase database
                          // by gmail and password
                          UserCredential userCredential =
                              await _auth.createUserWithEmailAndPassword(
                                  email: c_email.text.toString().trim(),
                                  password: c_password.text.toString().trim());
                          // set user id for get userInformation
                          UserData.userId = userCredential.user!.uid;
                          SettableMetadata metadata2 = SettableMetadata(
                            contentType: 'image/jpeg',
                            customMetadata: {
                              'caption': "User-image",
                              'content-name': _fileManagement.imagepath.value,
                              'author': UserData.firstUserName,
                              'time': DateTime.now().toString(),
                            },
                          );

                          String imageLink = await _fileManagement
                              .imgaeSenttoDataBase(UserData.userId, metadata2);
                          //add name & email of user
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                            'name': c_name.text.toString().trim(),
                            'email': c_email.text.toString().trim(),
                            'online': true,
                            "datetime": Timestamp.now(),
                            'imageLink': imageLink,
                          });

                          Get.offAndToNamed(Alluser.name);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Registation'),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
