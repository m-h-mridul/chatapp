// ignore_for_file: file_names

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import '../../../helper/media.dart';

// ignore: must_be_immutable
class Videoview extends StatefulWidget {
  String link;
  bool view;
  Videoview(this.link, this.view, {super.key});

  @override
  State<Videoview> createState() => _VideoviewState();
}

class _VideoviewState extends State<Videoview> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.link))
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: widget.view
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
            : const BorderRadius.only(
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
        border: Border.all(color: const Color(0xFF909090)),
      ),
      width: MediaQuerypage.screenWidth! * 0.6,
      height: MediaQuerypage.screenHeight! * 0.2,
      child: Center(
        child: CupertinoPageScaffold(
          child: CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController),
        ),
      ),
    );
  }
}
