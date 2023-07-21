// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:potro/model/userdata.dart';

import '../../helper/callingName.dart';
import '../../helper/offlinestroage.dart';
import '../home/home.dart';

showAlertDialog(BuildContext context) {
  // set up the button
  Widget canceloginButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget loginButton = TextButton(
    child: const Text("Logout"),
    onPressed: () async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserData.userId)
          .update({'online': false, "datetime": Timestamp.now()});
      await FirebaseAuth.instance.signOut();
      OfflineStrogae offlineStrogae = OfflineStrogae.instance;
      offlineStrogae.removeData(name: Callingname.userUid);
      Get.offAllNamed(MyHomePage.name);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Logout!"),
    content: const Text("You want to Logout ...."),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    actions: [canceloginButton, loginButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
