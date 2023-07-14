import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/fIlemanagemet.dart';
import '../../../helper/media.dart';
import '../sentitemview/imageviewforsent.dart';
import '../sentitemview/pdfviewer.dart';
import '../sentitemview/videoviewforsent.dart';

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
                    FileManagement fileManagement = FileManagement();
                    await fileManagement.imagegetfromGeleary(bc);
                    Get.back();
                    if (fileManagement.imagepath.value != "") {
                      Get.to(() => ImageViewer(fileManagement));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
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
                  onTap: () async {
                    FileManagement fileManagement = FileManagement();
                    await fileManagement.importPDF();
                    Get.back();
                    if (fileManagement.pdfpath.value != "") {
                      Get.to(() => Pdfviewer(fileManagement));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: MediaQuerypage.smallSizeWidth! * 13,
                        ),
                        const Text('PDF'),
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () async {
                    FileManagement fileManagement = FileManagement();
                    await fileManagement.videogetfromGeleary(bc);
                    Get.back();
                    if (fileManagement.videopath.value != "") {
                      Get.to(() => VidepViewforSent(fileManagement));
                    }
                    // FutureBuilder(
                    //     future: fileManagement.videogetfromGeleary(bc),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.connectionState ==
                    //               ConnectionState.done
                    //           ) {
                    //         Get.back();
                    //         Get.to(() => VidepViewforSent(fileManagement));
                    //       }
                    //       return const CircularProgressIndicator();
                    //     });
                  },
                  child: Container(
                    padding: EdgeInsets.all(MediaQuerypage.smallSizeWidth! * 1),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      children: [
                        Icon(
                          Icons.videocam,
                          size: MediaQuerypage.smallSizeWidth! * 13,
                        ),
                        Text(
                          'Video',
                          style: TextStyle(
                              fontSize: MediaQuerypage.textSize! * 15),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      });
}
