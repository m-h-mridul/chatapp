

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Service/image.dart';
import '../../../helper/media.dart';
import '../imageview.dart';

void settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 20),
            child: Wrap(
              spacing: 8.0,
              children: <Widget>[
                InkWell(
                    onTap: () async {
                      ImageController imageController = ImageController();
                      await imageController.imagegetfromGeleary(bc);
                      Get.back();
                      if (imageController.imagepath.value != "") {
                        Get.to(() => ImageViewer(imageController));
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: MediaQuerypage.smallSizeWidth! * 13,
                          ),
                          Text(
                            'Image',
                            style: TextStyle(
                                fontSize: MediaQuerypage.textSize! * 15),
                          ),
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () => {},
                    child: Container(
                      padding:
                          EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Icon(
                            Icons.picture_as_pdf,
                            size: MediaQuerypage.smallSizeWidth! * 13,
                          ),
                          Text('PDF'),
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () => {},
                    child: Container(
                      padding:
                          EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Icon(
                            Icons.videocam,
                            size: MediaQuerypage.smallSizeWidth! * 13,
                          ),
                          Text('Video'),
                        ],
                      ),
                    )),
              ],
            ),
          );
        });
  }