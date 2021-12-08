// ignore_for_file: file_names, unused_local_variable, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:chatapp/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList {
  // 
  Stream<QuerySnapshot<Map<String, dynamic>>> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  //
  // method calling for controller
  Stream<List<Alluserlist>> getalluser() => users.asyncMap((event) {
        List<Alluserlist> m = [];
        for (var element in event.docs) {
          if (UserData.userId != element.id.toString()) {
            // other user informatioin add
            m.add(Alluserlist(
                activestatius: element.get('online'),
                user_name: element.get('name')));
          } else {
            // for current user information
            UserData.firstUserName = element.get('name');
            UserData.email = element.get('email');
          }
        }
        return m;
      });
}
