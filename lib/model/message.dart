class Messages {
  Messages({
    required this.name,
    required this.text,
    required this.time,
    this.link = '',
    this.filename = '',
  });
  String time;
  String name;
  String text;
  String link = '';
  String filename = '';
}
