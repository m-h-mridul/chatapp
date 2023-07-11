// ignore_for_file: unused_element, unused_local_variable, non_constant_identifier_names
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import '../Service/filesentdatabase.dart';

class FileManagement {
  var imagepath = ''.obs;
  var videopath = ''.obs;

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
}
