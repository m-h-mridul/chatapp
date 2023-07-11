import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FileSentDatabase {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> imageSentFirebase(
      String imagepath, String uid, SettableMetadata metadata) async {
    String temp = '';
    try {
      await storage.ref(uid).putFile(File(imagepath), metadata);
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

Future<String> videoSentFirebase(
      String videpath, String uid, SettableMetadata metadata) async {
    String temp = '';
    try {
      await storage.ref(uid).putFile(File(videpath), metadata);
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
  
}
