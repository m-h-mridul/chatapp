import 'package:flutter/material.dart';
import '../../../helper/media.dart';

imageview(String secondUserImage, bool view) {
  return Image.network(
    secondUserImage,
    width: MediaQuerypage.screenWidth! * 0.55,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!.toDouble()
            : null,
      );
    },
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) =>
            Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: view
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
      child: Image(
        width: MediaQuerypage.screenWidth! * 0.5,
        height: MediaQuerypage.screenHeight! * 0.3,
        color: Colors.amber,
        image: const AssetImage(
          'assets/Image_not_available.png',
        ),
      ),
    ),
  );
}
