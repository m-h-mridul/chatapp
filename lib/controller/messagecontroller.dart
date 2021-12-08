// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_overrides, invalid_use_of_protected_member, avoid_print

import 'package:chatapp/Service/Messagedatabase.dart';
import 'package:chatapp/model/userdata.dart';
import 'package:chatapp/Service/FIrebaseUser.dart';
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
  // on it method default in getx
  @override
  Future<void> onInit() async {
    // message from firebase
    user = await FirebaseUser().messages_database_cheak();
    print(user.toString());
    //call Massage get functioin  for get user messages
    messageList.bindStream(Messagedatabase().message_getfirebase());
    await messgaeget();
    super.onInit();
  }

  messgaeget() async {
    // message from firebase
    user = await FirebaseUser().messages_database_cheak();
    print(user.toString());
    messageList.clear();
    //call Massage get functioin  for get user messages
    messageList.bindStream(Messagedatabase().message_getfirebase());
  }
}
