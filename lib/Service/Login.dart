
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:potro/helper/callingName.dart';
import 'package:potro/model/userdata.dart';
import 'package:potro/screen/Alluser/Alluser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../helper/offlinestroage.dart';

///firebase auth
final _auth = FirebaseAuth.instance;
loginButton(String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
        
    if (userCredential != null) {
      UserData.userId = userCredential.user!.uid;
      UserData.firstUserImage.value = userCredential.user!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'online': true});
      OfflineStrogae offlineStrogae = OfflineStrogae.instance;
      offlineStrogae.insertData(
          name: Callingname.userUid, value: UserData.userId);

      Get.offAndToNamed(Alluser.name);
      // Navigator.pushNamedAndRemoveUntil(
      //     context, Alluser.name, (Route<dynamic> route) => false);
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
