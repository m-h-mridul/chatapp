// ignore_for_file: unnecessary_null_comparison

import 'package:chatapp/model/userdata.dart';
import 'package:chatapp/screen/Alluser/Alluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

///firebase auth
final _auth = FirebaseAuth.instance;
login_buttom(String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    if (userCredential != null) {
      UserData.userId = userCredential.user!.uid;
      UserData.photourl = userCredential.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'online': true});
      // go to all user screen
      Navigator.pushNamedAndRemoveUntil(
          context, Alluser.name, (Route<dynamic> route) => false);
    } else {
      print('finding some errors \nuser not creat');
    }
  } catch (e) {
    print(e);
  }
}
