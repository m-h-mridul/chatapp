// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables, empty_catches



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:potro/model/userdata.dart';
import 'package:flutter/material.dart';
import 'package:potro/helper/media.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/fIlemanagemet.dart';
import '../../helper/snakber.dart';

class UserProfile extends StatelessWidget {
  static String name = '/FirstUser';
  UserProfile({Key? key}) : super(key: key);
  FileManagement imageController = FileManagement();
  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(" Profile"),
        backgroundColor: const Color(0xFF009688),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => InkWell(
                  onTap: () {
                    imageController.imagegetfromGeleary(context);
                  },
                  child: imageController.imagepath.value.isNotEmpty
                      ? Image.network(
                          imageController.imagepath.value,
                          width: MediaQuerypage.screenWidth,
                          height: MediaQuerypage.screenHeight! / 4,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                                child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                          .toDouble()
                                  : null,
                            ));
                          },
                          errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) =>
                              Image(
                            width: MediaQuerypage.screenWidth,
                            height: MediaQuerypage.screenHeight! / 4,
                            color: const Color(0xFF009688),
                            image: const AssetImage(
                              'assets/user.png',
                            ),
                          ),
                        )
                      : Image.network(
                          UserData.firstUserImage.value,
                          width: MediaQuerypage.screenWidth,
                          height: MediaQuerypage.screenHeight! / 4,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                                child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                          .toDouble()
                                  : null,
                            ));
                          },
                          errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) =>
                              Image(
                            width: MediaQuerypage.screenWidth,
                            height: MediaQuerypage.screenHeight! / 4,
                            color: const Color(0xFF009688),
                            image: const AssetImage(
                              'assets/user.png',
                            ),
                          ),
                        )
            
                  // largeimageviewForProfile(UserData.firstUserImage.value)
                  ),
            ),
          ),
          Card(
            child: Container(
              width: MediaQuerypage.screenWidth,
              height: MediaQuerypage.screenHeight! / 16,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: Colors.blueAccent)
              ),
              child: Text(" Name :  ${UserData.firstUserName}",
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
          Card(
            child: Container(
              width: MediaQuerypage.screenWidth,
              height: MediaQuerypage.screenHeight! / 16,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // border: Border.all(color: Colors.blueAccent)
              ),
              child: Text(" Email :  ${UserData.email}",
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      padding: EdgeInsets.fromLTRB(
                          MediaQuerypage.smallSizeWidth! * 8,
                          MediaQuerypage.smallSizeHeight! * 2,
                          MediaQuerypage.smallSizeWidth! * 8,
                          MediaQuerypage.smallSizeHeight! * 2)),
                  onPressed: () async {
                    try {
                      SettableMetadata metadata2 = SettableMetadata(
                        contentType: 'image/jpeg',
                        customMetadata: {
                          'caption': "User-image",
                          'content-name': imageController.imagepath.value,
                          'author': UserData.firstUserName,
                          'time': DateTime.now().toString(),
                        },
                      );
                      String imageLink = await imageController
                          .imgaeSenttoDataBase(UserData.userId, metadata2);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(UserData.userId)
                          .update({
                        // 'name': c_name.text.toString().trim(),
                        'imageLink': imageLink,
                      });
                      viewSnakber("Image", "Successfully Image sent database");
                    } catch (e) {
                      viewSnakber("Image", e.toString());
                    }
                  },
                  child: const Text('Save',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.fromLTRB(
                        MediaQuerypage.smallSizeWidth! * 10,
                        MediaQuerypage.smallSizeHeight! * 2,
                        MediaQuerypage.smallSizeWidth! * 10,
                        MediaQuerypage.smallSizeHeight! * 2),
                    side: const BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
