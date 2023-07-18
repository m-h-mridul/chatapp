import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:potro/helper/loadingwidget.dart';
import 'package:potro/helper/media.dart';
import 'package:potro/helper/snakber.dart';
import 'package:potro/screen/messageing/itemviewr%20and%20download/forvideo.dart';

import '../../../Service/downloaditem.dart';

class ItemViewer extends StatelessWidget {
  String value;
  String link;
  String filename;
  ItemViewer(this.value, this.link, this.filename, {super.key});

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(filename),
          backgroundColor: const Color(0xFF009688),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: downloadItem(
              link: link,
              filename: filename,
              scaffoldMessenger: scaffoldMessenger),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final data = snapshot.data as String;
                if (value == 'image') {
                  return Center(child: Image.file(File(data)));
                } else if (value == 'video') {
                  Forsavevideo(data);
                } else if (value == 'pdf') {
                  return SizedBox(
                    width: MediaQuerypage.screenWidth!,
                    child: PDFView(
                      filePath: data,
                    ),
                  );
                } else {
                  return SizedBox(
                      width: MediaQuerypage.screenWidth!,
                      height: MediaQuerypage.screenHeight! * 0.6,
                      child: Image.file(File('assets/unknown-image.webp')));
                }
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return loadingScreen();
          },
        ),
      ),
    );
  }
}
