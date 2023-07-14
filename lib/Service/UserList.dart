// ignore_for_file: file_names, unused_local_variable, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:potro/model/alluserlist.dart';
import 'package:potro/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:potro/model/userstatus.dart';
import 'Messagedatabase.dart';

class UserList {
  Stream<QuerySnapshot<Map<String, dynamic>>> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  Stream<List<Alluserlist>> getalluser() => users.asyncMap((event) async {
        List<Alluserlist> m = [];
        for (var element in event.docs) {
          if (UserData.userId != element.id.toString()) {
            Alluserlist alluserlist = Alluserlist(
              activestatius: element.get('online'),
              userName: element.get('name'),
              userUid: element.id.toString(),
              lastactive: element.get("datetime"),
              imageLink: element.get("imageLink")??" ",
            );
            // CollectionReference<Map<String, dynamic>> databseName =
            //     Messagedatabase().userMessageStatus(alluserlist.userName);
            // alluserlist.lastMessageUser
            //     .bindStream(getUserMessagesttus(databseName));
            m.add(alluserlist);
          } else {
            // for current user information
            UserData.firstUserName = element.get('name');
            UserData.email = element.get('email');
            UserData.firstUserImage.value = element.get("imageLink");
          }
        }
        return m;
      });

  Stream<List<UserStatus>> getUserMessagesttus(
      CollectionReference<Map<String, dynamic>> collectionReference) {
    return collectionReference.snapshots().asyncMap((event) {
      List<UserStatus> temp = [];
      for (var element in event.docs) {
        temp.add(
          UserStatus(
            user: element.get('user'),
            text: element.get('text'),
            time: element.get('time'),
            count: element.get('count').toString(),
            datatime: element.get('datetime').toString(),
          ),
        );
      }
      return temp;
    });
  }
}
