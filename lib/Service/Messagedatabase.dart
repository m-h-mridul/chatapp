// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, file_names

import 'package:chatapp/controller/messagecontroller.dart';
import 'package:chatapp/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';

class Messagedatabase {
  // for current get class intenis
  MessageController controller = Get.find();
  // Get message from firebase database
  Stream<List<Messages>> message_getfirebase() => controller.userdata!
          .orderBy("datetime", descending: false)
          .snapshots()
          .asyncMap((event) {
        print("message list working..");
        List<Messages> message = [];
        for (var element in event.docs) {
          message.add(Messages(
              name: element.get('user'),
              text: element.get('text'),
              time: element.get('time')));
        }
        return message;
      });
// message sent into database
  Future<void> messagesent(String text) async {
    await controller.userdata!.add({
      "text": text,
      "user": UserData.firstUserName,
      "datetime": Timestamp.now(),
      "time": DateFormat("hh:mm:ss a").format(DateTime.now()),
    }).whenComplete(() => print("comleted"));
  }
}
