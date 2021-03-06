// ignore_for_file: unnecessary_new, unused_local_variable, unnecessary_null_comparison, non_constant_identifier_names, avoid_print, must_be_immutable

import 'dart:io';
import 'package:chatapp/controller/imagecontroller.dart';
import 'package:chatapp/model/userdata.dart';
import 'package:chatapp/screen/Alluser/Alluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../media.dart';

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
  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    // button style
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: const Color(0xFF009688),
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
                        imageController.openGallery(context);
                      },
                      child: Obx(() => imageController.imagepath.value != ''
                          ? Image.file(
                              File(imageController.imagepath.value),
                              width: MediaQuerypage.screenWidth! / 2,
                              height: MediaQuerypage.screenHeight! / 4,
                            )
                          : Image(
                              fit: BoxFit.fill,
                              width: MediaQuerypage.screenWidth! / 2,
                              height: MediaQuerypage.screenHeight! / 4,
                              color: const Color(0xFF009688),
                              image: AssetImage(
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
                          UserData.photourl= userCredential.user!.uid;
                          //add name & email of user
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userCredential.user!.uid)
                              .set({
                            'name': c_name.text.toString().trim(),
                            'email': c_email.text.toString().trim(),
                            'online': true
                          });
                          await imageController
                              .image_sentFirebase(UserData.userId);
                          // and goto into the app
                          Navigator.pushNamedAndRemoveUntil(context,
                              Alluser.name, (Route<dynamic> route) => false);
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
