
class Messages {
  Messages(
      {required this.name,
      required this.text,
      required this.time,
      this.link = ''});
  String time;
  String name;
  String text;
  String link = '';
}