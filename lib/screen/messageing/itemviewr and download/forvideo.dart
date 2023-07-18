// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../helper/media.dart';

class Forsavevideo extends StatelessWidget {
  String filename;
  Forsavevideo(this.filename, {super.key});
  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = VideoPlayerController.file(File(filename));

    return Center(
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
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
