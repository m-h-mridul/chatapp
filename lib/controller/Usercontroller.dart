// ignore_for_file: file_names, invalid_use_of_protected_member, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/Service/UserList.dart';
import 'package:potro/model/userdata.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/alluserlist.dart';
import '../model/userstatus.dart';

class Usercontroller extends GetxController {
  RxList<Alluserlist> userName = RxList<Alluserlist>();
  RxList<UserStatus> lastMessageUser = RxList<UserStatus>();
  CollectionReference<Map<String, dynamic>>? lastMessageStatus;

  //
  @override
  Future<void> onInit() async {
    userName.bindStream(UserList().getalluser());
    lastMessageStatus = await Messagedatabase().userMessageStatus();
    lastMessageUser
        .bindStream(UserList().getUserMessagesttus(lastMessageStatus!));
    super.onInit();
  }
}
