import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:potro/helper/snakber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

Future<String> downloadItem(
    {String? link,
    String? filename,
    ScaffoldMessengerState? scaffoldMessenger}) async {
  String? message;
  final appDir = await getApplicationDocumentsDirectory();
  final filePath = '${appDir.path}/potro/$filename';
  final response = await http.get(Uri.parse(link!));
  if (response.statusCode == 200) {
    File file = File(filePath);
    if (!file.existsSync()) {
      file.create(recursive: true);
    }
    await file.writeAsBytes(response.bodyBytes);
    // Ask the user to save it
    final params = SaveFileDialogParams(sourceFilePath: file.path);
    final finalPath = await FlutterFileDialog.saveFile(params: params);

    if (finalPath != null) {
      message = 'Image saved to disk';
    }

    if (message != null) {
      scaffoldMessenger!.showSnackBar(SnackBar(content: Text(message)));
    }
  } else {
    viewSnakber('image download', response.statusCode.toString());
  }
  return filePath;
}
