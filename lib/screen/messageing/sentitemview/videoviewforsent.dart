// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:potro/controller/fIlemanagemet.dart';
import 'package:video_player/video_player.dart';
import '../../../Service/Messagedatabase.dart';
import '../../../controller/messagecontroller.dart';
import '../../../helper/media.dart';
import '../../../model/userdata.dart';

class VidepViewforSent extends StatelessWidget {
  FileManagement fileManagement;
  VidepViewforSent(this.fileManagement, {super.key});
  late VideoPlayerController _controller;
  TextEditingController metadata = TextEditingController();
  MessageController controller = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    _controller =
        VideoPlayerController.file(File(fileManagement.videopath.value));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(),
            Positioned(
                top: MediaQuerypage.smallSizeHeight! * 16,
                child: Center(
                  child: FutureBuilder(
                      future: _controller.initialize(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            width: MediaQuerypage.screenWidth!,
                            height: MediaQuerypage.screenHeight! * 0.4,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          );
                        } else {
                          return const SizedBox(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      }),
                )),

            // Image.file(
            //   File(fileController.imagepath.value),
            //   width: MediaQuerypage.screenWidth!,
            //   height: MediaQuerypage.screenHeight! * 0.6,
            //   fit: BoxFit.fill,
            // ),

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
                            contentType: 'image/jpeg',
                            customMetadata: {
                              'caption': metadata.text,
                              'content-name': fileManagement.videopath.value,
                              'author': UserData.firstUserName,
                              'time': DateTime.now().toString(),
                            },
                          );
                          String temp =
                              fileManagement.videopath.value.split("/").last;
                          String link =
                              await fileManagement.videoSenttoDataBase(
                                  "${controller.user!.id}/$temp", metadata2);
                          await Messagedatabase()
                              .documentsentdata('video', link);

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


