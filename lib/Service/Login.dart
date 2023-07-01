
import 'package:flutter/foundation.dart';
import 'package:potro/model/userdata.dart';
import 'package:potro/screen/Alluser/Alluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

///firebase auth
final _auth = FirebaseAuth.instance;
loginButton(String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      UserData.userId = userCredential.user!.uid;
      UserData.firstUserImage.value = userCredential.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'online': true});
      // go to all user screen
      Navigator.pushNamedAndRemoveUntil(
          context, Alluser.name, (Route<dynamic> route) => false);
    } else {
      if (kDebugMode) {
        print('finding some errors \nuser not creat');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
