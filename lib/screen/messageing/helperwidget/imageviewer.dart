import 'package:flutter/material.dart';
import '../../../helper/media.dart';

imageview(String secondUserImage) {
  return Image.network(
    secondUserImage,
    width: MediaQuerypage.screenWidth! * 0.55,
    // height: MediaQuerypage.screenHeight! * 0.3,
    loadingBuilder: (BuildContext context, Widget child,
        ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return SizedBox(
        width: MediaQuerypage.screenWidth! * 0.5,
        height: MediaQuerypage.screenHeight! * 0.3,
        child: Center(
            child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!.toDouble()
              : null,
        )),
      );
    },
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) =>
            Image(
      width: MediaQuerypage.screenWidth! * 0.5,
      height: MediaQuerypage.screenHeight! * 0.3,
      color: Colors.amber,
      image: const AssetImage(
        'assets/user.png',
      ),
    ),
  );
}
