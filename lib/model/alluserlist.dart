// All user list and active status
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:potro/model/userstatus.dart';

class Alluserlist {
  Alluserlist({
    required this.userName,
    required this.activestatius,
    required this.userUid,
    required this.lastactive,
    required this.imageLink,
    required this.usertoken,
  });
  String userName;
  bool activestatius;
  String userUid;
  Timestamp lastactive = Timestamp.now();
  String imageLink;
  String usertoken;
  RxList<UserStatus> lastMessageUser = RxList<UserStatus>();
}
