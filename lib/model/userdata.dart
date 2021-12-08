// current user and sent message other user
class UserData {
  static String photourl = '';
  static String userId = '';
  static String email = "";
  static String secondUserName = "";
  static String firstUserName = "";
}

// All user list and active status
class Alluserlist {
  Alluserlist({required this.user_name, required this.activestatius});
  String user_name;
  bool activestatius;
}

// for messageing
class Messages {
  Messages({required this.name, required this.text, required this.time});
  String time;
  String name;
  String text;
}
