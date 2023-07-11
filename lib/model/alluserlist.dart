// All user list and active status
import 'package:cloud_firestore/cloud_firestore.dart';

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
  
}