
import 'package:chatapp/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home/home.dart';


showAlertDialog(BuildContext context) {
  // set up the button
  Widget C_Button = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget L_Button = TextButton(
    child: Text("Logout"),
    onPressed: () async {
      // make flase user that he/she are off line
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserData.userId)
          .update({
        'online': false
      });
      // signout from firebase
      await FirebaseAuth.instance.signOut();
      // goto the app home screen
      Navigator.pushNamedAndRemoveUntil(
          context, MyHomePage.name, (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout!"),
    content: Text("You want to Logout ...."),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    actions: [C_Button, L_Button],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
