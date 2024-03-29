// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, file_names, non_constant_identifier_names

import 'package:potro/controller/messagecontroller.dart';
import 'package:potro/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';
import '../model/message.dart';

class Messagedatabase {
  // Get message from firebase database
  Stream<List<Messages>> message_getfirebase() {
    MessageController controller = Get.find<MessageController>();
    return controller.userdata!
        .orderBy("datetime", descending: false)
        .snapshots()
        .asyncMap((event) {
      print("message list working..");
      List<Messages> message = [];
      for (var element in event.docs) {
        message.add(
          Messages(
            name: element.get('user'),
            text: element.get('text'),
            time: element.get('time'),
            link: element.get('link') ?? "",
            filename: element.get('filename') ?? "",
          ),
        );
      }
      return message;
    });
  }

  // message sent into database
  Future<void> messagesent(String text) async {
    MessageController controller = Get.find();
    await controller.userdata!.add({
      "text": text,
      'link': "",
      'filename': '',
      "user": UserData.firstUserName,
      "datetime": Timestamp.now(),
      "time": DateFormat("hh:mm:ss a").format(DateTime.now()),
    }).whenComplete(() => print("comleted"));

    await controller.userMessageStatus!.doc('status').set({
      "count": 1,
      "text": text,
      "user": UserData.firstUserName,
      "datetime": Timestamp.now(),
      "time": DateFormat("hh:mm:ss a").format(DateTime.now()),
    }).whenComplete(() => print("comleted"));
  }

  Future<void> documentsentdata(String text, String name, String link) async {
    MessageController controller = Get.find();
    await controller.userdata!.add({
      "text": text,
      'link': link,
      'filename': name,
      "user": UserData.firstUserName,
      "datetime": Timestamp.now(),
      "time": DateFormat("hh:mm:ss a").format(DateTime.now()),
    }).whenComplete(() => print("comleted"));

    await controller.userMessageStatus!.doc('status').update({
      "count": 1,
      "text": text,
      "user": UserData.firstUserName,
      "datetime": Timestamp.now(),
      "time": DateFormat("hh:mm:ss a").format(DateTime.now()),
    }).whenComplete(() => print("comleted"));
  }

  Future<CollectionReference<Map<String, dynamic>>>
      messages_database_cheak() async {
    QuerySnapshot<Map<String, dynamic>> users = await FirebaseFirestore.instance
        .collection(UserData.firstUserName + UserData.secondUserName)
        .get();
    final userone = FirebaseFirestore.instance
        .collection(UserData.firstUserName + UserData.secondUserName);
    final usertwo = FirebaseFirestore.instance
        .collection(UserData.secondUserName + UserData.firstUserName);
    return (users.docs.isNotEmpty) ? userone : usertwo;
  }

  CollectionReference<Map<String, dynamic>> userMessageStatus(
      String secoondUser) {
    Stream<QuerySnapshot<Map<String, dynamic>>> users = FirebaseFirestore
        .instance
        .collection("${UserData.firstUserName}$secoondUser status-view")
        .snapshots();

    final userone = FirebaseFirestore.instance.collection(
        "${UserData.firstUserName}${UserData.secondUserName} status-view");
    final usertwo = FirebaseFirestore.instance
        .collection("$secoondUser${UserData.firstUserName} status-view");

    return (users.isBroadcast) ? usertwo : userone;
  }
}
