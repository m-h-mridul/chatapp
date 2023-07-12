// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_overrides, invalid_use_of_protected_member, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:potro/model/userdata.dart';

class MessageController extends GetxController {
  RxList<Messages> messageList = RxList<Messages>();
  List<Messages> get messagelist => messageList.value;

  CollectionReference<Map<String, dynamic>>? user;
  CollectionReference<Map<String, dynamic>>? get userdata => user;
  CollectionReference<Map<String, dynamic>>? userMessageStatus;

  @override
  Future<void> onInit() async {
    user = await Messagedatabase().messages_database_cheak();
    userMessageStatus=Messagedatabase().userMessageStatus(UserData.secondUserName);
    messageList.bindStream(Messagedatabase().message_getfirebase());
    // await messgaeget();
    super.onInit();
  }

  // messgaeget() async {
  //   // message from firebase
  //   // var temp = await Messagedatabase().messages_database_cheak();
  //   // user = temp[0];
  //   // lastMessage = temp[1];
  //   print(user.toString());
  //   messageList.clear();
  //   //call Massage get functioin  for get user messages
  //   messageList.bindStream(Messagedatabase().message_getfirebase());
  // }
}
