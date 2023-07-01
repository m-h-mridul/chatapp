// ignore_for_file: unused_element, unused_local_variable, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:potro/model/userdata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class ImageController {
  var imagepath = ''.obs;
  var firebase_image_url = ''.obs;

  FirebaseStorage storage = FirebaseStorage.instance;
  //
   imagegetfromGeleary(BuildContext context) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      imagepath.value = image!.path;
    } catch (e) {
      debugPrint('Problem finding in openGallery method\n form controller');
      debugPrint(e.toString());
    }
  }

  //image sent firebase here using uid for store
  Future<String> image_sentFirebase(String uid,SettableMetadata metadata) async {
    String temp = '';
    try {
      await storage.ref(uid).putFile(File(imagepath.value),metadata);
      temp = await storage.ref(uid).getDownloadURL();
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    return temp;
  }

  //image get from database
  void imageGet() async {
    try {
      firebase_image_url.value =
          await storage.ref(UserData.firstUserImage.value).getDownloadURL();
      if (kDebugMode) {
        print(firebase_image_url.value);
      }
    } catch (e) {
      debugPrint('Error finding in image get method');
      debugPrint(' errors is ${e.toString()}');
    }
  }
}
