// ignore_for_file: unused_element, unused_local_variable, non_constant_identifier_names
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import '../Service/filesentdatabase.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../helper/snakber.dart';

class FileManagement {
  var imagepath = ''.obs;
  var videopath = ''.obs;
  var pdfpath = ''.obs;

  FirebaseStorage storage = FirebaseStorage.instance;
  final FileSentDatabase _fileSentDatabase = FileSentDatabase();

  imagegetfromGeleary(BuildContext context) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagepath.value = image.path;
      }
    } catch (e) {
      debugPrint('Problem finding in openGallery method\n form controller');
      debugPrint(e.toString());
    }
  }

  videogetfromGeleary(BuildContext context) async {
    try {
      XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (video != null) {
        videopath.value = video.path;
      }
    } catch (e) {
      debugPrint('Problem finding in openGallery method  form controller');
      debugPrint(e.toString());
    }
  }

  Future<String> videoSenttoDataBase(
      String uid, SettableMetadata metadata) async {
    return await _fileSentDatabase.videoSentFirebase(
        videopath.value, uid, metadata);
  }

  Future<String> imgaeSenttoDataBase(
      String uid, SettableMetadata metadata) async {
    return await _fileSentDatabase.imageSentFirebase(
        imagepath.value, uid, metadata);
  }

  Future<String> pdfSenttoDataBase(
      String uid, SettableMetadata metadata) async {
    return await _fileSentDatabase.imageSentFirebase(
        pdfpath.value, uid, metadata);
  }

  // Import a PDF file
  importPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        pdfpath.value = result.files.single.path!;
      }
    } catch (e) {
      viewSnakber('Error on pddf get', e.toString());
    }
  }
}
