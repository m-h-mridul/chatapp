import 'package:flutter/material.dart';
import '../../../helper/media.dart';

imageview(String secondUserImage) {
    return Image.network(
      secondUserImage,
      width: MediaQuerypage.screenWidth! / 10,
      height: MediaQuerypage.screenHeight! / 30,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
            child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!.toDouble()
              : null,
        ));
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              Image(
        width: MediaQuerypage.screenWidth! / 10,
        height: MediaQuerypage.screenHeight! / 30,
        color: Colors.amber,
        image: const AssetImage(
          'assets/user.png',
        ),
      ),
    );
  }