import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:potro/model/userdata.dart';
import '../../../Service/Messagedatabase.dart';
import '../../../controller/fIlemanagemet.dart';
import '../../../controller/messagecontroller.dart';
import '../../../helper/media.dart';

// void sendFile(String filePath) async {
//   if (await canLaunch(filePath)) {
//     await launch(filePath);
//   } else {
//     throw 'Could not launch $filePath';
//   }
// }

class Pdfviewer extends StatelessWidget {
  FileManagement fileController;
  Pdfviewer(this.fileController, {super.key});

  MessageController controller = Get.find<MessageController>();
  TextEditingController metadata = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(),
            Positioned(
              top: MediaQuerypage.smallSizeHeight! * 8,
              child: SizedBox(
                width: MediaQuerypage.screenWidth!,
                height: MediaQuerypage.screenHeight! * 0.6,
                child: PDFView(
                  filePath: fileController.pdfpath.value,
                ),
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
                          SettableMetadata metadata2 = SettableMetadata(
                            contentType: 'document/pdf',
                            customMetadata: {
                              'caption': metadata.text,
                              'content-name': fileController.imagepath.value,
                              'author': UserData.firstUserName,
                              'time': DateTime.now().toString(),
                            },
                          );
                          String temp =
                              fileController.pdfpath.value.split("/").last;
                          String link =
                              await fileController.pdfSenttoDataBase(
                                  "${controller.user!.id}/$temp", metadata2);
                          await Messagedatabase()
                              .documentsentdata('pdf',temp ,link);

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
