// ignore_for_file: file_names, invalid_use_of_protected_member, avoid_print, non_constant_identifier_names

import 'package:potro/Service/UserList.dart';
import 'package:potro/model/userdata.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Usercontroller extends GetxController {
  RxList<Alluserlist> userName = RxList<Alluserlist>();
  List<Alluserlist>? get username => userName.value;

  //
  @override
  void onInit() {
    print('user Controller class ');
    userName.bindStream(UserList().getalluser());
    super.onInit();
  }
}
