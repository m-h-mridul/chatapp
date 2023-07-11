// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Service/Messagedatabase.dart';
import '../../../controller/fIlemanagemet.dart';
import '../../../controller/messagecontroller.dart';
import '../../../helper/media.dart';
import '../../../model/userdata.dart';

// ignore: must_be_immutable
class ImageViewer extends StatelessWidget {
  FileManagement fileController;
  ImageViewer(
    this.fileController, {
    Key? key,
  }) : super(key: key);
  MessageController controller = Get.find<MessageController>();
  TextEditingController metadata = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(),
            Positioned(
              top: MediaQuerypage.smallSizeHeight! * 8,
              child: Image.file(
                File(fileController.imagepath.value),
                width: MediaQuerypage.screenWidth!,
                height: MediaQuerypage.screenHeight! * 0.6,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuerypage.smallSizeHeight! * 12,
                left: 2,
                right: 2,
              ),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: const Color(0xFFADBABF),
                child: Row(
                  children: [
                    Text(
                      'name   ',
                      style: TextStyle(
                          fontSize: MediaQuerypage.textSize! * 16,
                          color: Colors.white),
                    ),
                    Expanded(
                        child: TextField(
                      controller: metadata,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFA0A1A4),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(11)),
                      ),
                    )),
                    IconButton(
                        onPressed: () async {
                          // Create a metadata object with custom metadata
                          SettableMetadata metadata2 = SettableMetadata(
                            contentType: 'image/jpeg',
                            customMetadata: {
                              'caption': metadata.text,
                              'content-name': fileController.imagepath.value,
                              'author': UserData.firstUserName,
                              'time': DateTime.now().toString(),
                            },
                          );
                          String temp =
                              fileController.imagepath.value.split("/").last;
                          String link =
                              await fileController.imgaeSenttoDataBase(
                                  "${controller.user!.id}/$temp", metadata2);
                          await Messagedatabase()
                              .documentsentdata('image', link);

                          Get.back();
                        },
                        icon: Icon(
                          Icons.done_outline,
                          color: Colors.white,
                          size: MediaQuerypage.pixels! * 11,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
