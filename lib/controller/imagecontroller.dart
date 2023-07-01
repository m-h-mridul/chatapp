// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:potro/model/userdata.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageController {
//   var imagepath = ''.obs;
//   var firebaseImageUrl = ''.obs;

//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   //
//   void openGallery(BuildContext context) async {
//     try {
//       XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       imagepath.value = image!.path;
//     } catch (e) {
//       debugPrint('Problem finding in openGallery method\n form controller');
//       debugPrint(e.toString());
//     }
//   }

//   //image sent firebase here using uid for store
//   imageSentFirebase(String uid) async {
//     try {
//       Reference ref = _storage.ref().child('images/$uid/');
//       String imageDownloadLink = await _storage
//           .ref(uid)
//           .putFile(File(imagepath.value))
//           .snapshot
//           .ref
//           .getDownloadURL();
//       String uploadTask2 = await ref
//           .putFile(File(imagepath.value))
//           .snapshot
//           .ref
//           .getDownloadURL();
//       return imageDownloadLink;
//     } on FirebaseException catch (error) {
//       if (kDebugMode) {
//         print(error);
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//   }

//   //image get from database
//   void imageGet() async {
//     try {
//       firebaseImageUrl.value =
//           await _storage.ref(UserData.firstUserImage.value).getDownloadURL();
//     } catch (e) {
//       debugPrint('Error finding in image get method');
//       debugPrint(' errors is ${e.toString()}');
//     }
//   }
// }
