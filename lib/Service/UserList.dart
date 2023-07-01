// ignore_for_file: file_names, unused_local_variable, avoid_print, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:potro/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Messagedatabase.dart';

class UserList {
  //
  Stream<QuerySnapshot<Map<String, dynamic>>> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  //
  // method calling for controller
  Stream<List<Alluserlist>> getalluser() => users.asyncMap((event) async {
        List<Alluserlist> m = [];
        for (var element in event.docs) {
          if (UserData.userId != element.id.toString()) {
            // other user informatioin add
            Alluserlist alluserlist = Alluserlist(
              activestatius: element.get('online'),
              userName: element.get('name'),
              userUid: element.id.toString(),
              lastactive: element.get("datetime"),
              imageLink: element.get("imageLink"),
            );
            // databse name get then
            // get the last message of conversation
            alluserlist.lastMessage.bindStream(Messagedatabase()
                .lastMessageGetDatabse(
                    await Messagedatabase().lastMessagesDatabaseCheak()));

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
}
