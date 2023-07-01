// current user and sent message other user
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/get_rx.dart';

class UserData {
  // first user image willbe change the variable name

  static String userId = '';
  static String email = "";
  static String secondUserName = "";
  static String firstUserName = "";
  static RxString firstUserImage = "".obs;
  static String secondUserActiveTime = "";
  static RxString secondUserImage = "".obs;
}

// All user list and active status
class Alluserlist {
  Alluserlist({
    required this.userName,
    required this.activestatius,
    required this.userUid,
    required this.lastactive,
    required this.imageLink,
  });
  String userName;
  bool activestatius;
  String userUid;
  Timestamp lastactive = Timestamp.now();
  String imageLink;
  RxList<Messages> lastMessage = RxList<Messages>();
}

// for messageing
class Messages {
  Messages({required this.name, required this.text, required this.time});
  String time;
  String name;
  String text;
}
