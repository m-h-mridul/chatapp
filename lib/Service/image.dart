// // ignore_for_file: unused_element, unused_local_variable, non_constant_identifier_names

// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:potro/model/userdata.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageController extends GetxController {
//   var imagepath = ''.obs;
//   var firebase_image_url = ''.obs;

//   FirebaseStorage storage = FirebaseStorage.instance;
//   //
//   void imagegetfromGeleary(BuildContext context) async {
//     try {
//       XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       imagepath.value = image!.path;
//     } catch (e) {
//       debugPrint('Problem finding in openGallery method\n form controller');
//       debugPrint(e.toString());
//     }
//   }

//   //image sent firebase
//   //here using uid for store
//   //image in firebase
//   Future<String> image_sentFirebase(String uid) async {
//     var temp = '';
//     try {
//       // Uploading the selected image with some custom meta data
//       await storage.ref(uid).putFile(File(imagepath.value));
//       temp = await storage.ref(uid).getDownloadURL();
//     } on FirebaseException catch (error) {
//       if (kDebugMode) {
//         print(error);
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//     return temp;
//   }

//   //image get from database
//   void imageGet() async {
//     try {
//       firebase_image_url.value =
//           await storage.ref(UserData.firstUserImage.value).getDownloadURL();
//       if (kDebugMode) {
//         print(firebase_image_url.value);
//       }
//     } catch (e) {
//       debugPrint('Error finding in image get method');
//       debugPrint(' errors is ${e.toString()}');
//     }
//   }
// }
