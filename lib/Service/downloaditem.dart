import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:potro/helper/snakber.dart';

Future<String> downloadItem({String? link, String? filename}) async {
  final appDir = await getApplicationDocumentsDirectory();
  final filePath = '${appDir.path}/potro/$filename';
  final response = await http.get(Uri.parse(link!));
  if (response.statusCode == 200) {
    File file = File(filePath);
    if (!file.existsSync()) {
      file.create(recursive: true);
    }
    await file.writeAsBytes(response.bodyBytes);
  } else {
    viewSnakber('image download', response.statusCode.toString());
  }
  return filePath;
}
