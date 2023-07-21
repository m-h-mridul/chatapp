// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:potro/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

facebok_login() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  UserData.userId = userCredential.user!.uid;
  UserData.firstUserImage.value = userCredential.user!.photoURL!;
  UserData.firstUserName = userCredential.user!.displayName!;
  UserData.email = userCredential.user!.email!;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userCredential.user!.uid)
      .set({
    'name': UserData.firstUserName,
    'email': UserData.email,
    'imageLink': UserData.firstUserImage,
    'online': true,
  });
}
