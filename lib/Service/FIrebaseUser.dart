// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:chatapp/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  // cheak that the communation is
  // first time or not
  Future<CollectionReference<Map<String, dynamic>>>
      messages_database_cheak() async {
    print('Cheak user message first time or not ');
    QuerySnapshot<Map<String, dynamic>> users = await FirebaseFirestore.instance
        .collection(UserData.firstUserName + UserData.secondUserName)
        .get();
    print("user ans " + users.docs.isNotEmpty.toString());
    final userone = FirebaseFirestore.instance
        .collection(UserData.firstUserName + UserData.secondUserName);
    final usertwo = FirebaseFirestore.instance
        .collection(UserData.secondUserName + UserData.firstUserName);
    return (users.docs.isNotEmpty) ? userone : usertwo;
  }
}
