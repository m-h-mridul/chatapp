// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserStatus {
  String count;
  String datatime;
  String text;
  String time;
  String user;
  bool seen = false;
  UserStatus(
      {required this.count,
      required this.datatime,
      required this.text,
      required this.time,
      required this.user,
      required this.seen});
}
