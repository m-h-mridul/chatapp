import 'dart:io';

import 'package:flutter/material.dart';
import 'package:potro/helper/media.dart';

import '../../../Service/downloaditem.dart';

class ItemViewer extends StatelessWidget {
  String value;
  String link;
  String filename;
  ItemViewer(this.value, this.link, this.filename, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuerypage.textSize! * 16)),
            ),
            SizedBox(
              width: MediaQuerypage.smallSizeWidth! * 4,
            ),
          ],
        ),
        body: FutureBuilder(
          future: downloadItem(link: link, filename: filename),
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
                }
                return Center(
                  child: Text(
                    '$data',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
