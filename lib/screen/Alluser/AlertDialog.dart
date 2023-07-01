import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:potro/model/userdata.dart';

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
      // make flase user that he/she are off line
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserData.userId)
          .update({'online': false, "datetime": Timestamp.now()});
      // signout from firebase
      await FirebaseAuth.instance.signOut();
      // goto the app home screen
      Navigator.pushNamedAndRemoveUntil(
          context, MyHomePage.name, (Route<dynamic> route) => false);
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
