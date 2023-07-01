// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_overrides, invalid_use_of_protected_member, avoid_print, non_constant_identifier_names

import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/model/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessageController extends GetxController {
  // list variable cret messages into the list
  RxList<Messages> messageList = RxList<Messages>();
  List<Messages> get messagelist => messageList.value;
  //
  // which name of database that the messages store
  //
  CollectionReference<Map<String, dynamic>>? user;
  CollectionReference<Map<String, dynamic>>? get userdata => user;

  //
  // for last message
  //
  CollectionReference<Map<String, dynamic>>? lastMessage_database;

  //
  // on it method default in getx
  @override
  Future<void> onInit() async {
    // message from firebase
    user = await Messagedatabase().messages_database_cheak();
    lastMessage_database = await Messagedatabase().lastMessagesDatabaseCheak();
    //call Massage get functioin  for get user messages
    messageList.bindStream(Messagedatabase().message_getfirebase());
    // await messgaeget();
    super.onInit();
  }

  messgaeget() async {
    // message from firebase
    // var temp = await Messagedatabase().messages_database_cheak();
    // user = temp[0];
    // lastMessage = temp[1];
    print(user.toString());
    messageList.clear();
    //call Massage get functioin  for get user messages
    messageList.bindStream(Messagedatabase().message_getfirebase());
  }
}
