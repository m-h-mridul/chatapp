import 'package:flutter/widgets.dart';

class MediaQuerypage {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? smallSizeHeight;
  static double? smallSizeWidth;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? pixels;
  static double? textSize;

  MediaQuerypage.init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    textSize = mediaQueryData!.textScaleFactor;
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
    smallSizeWidth = screenWidth! / 100;
    smallSizeHeight = screenHeight! / 100;
    pixels = mediaQueryData!.devicePixelRatio;
    _safeAreaHorizontal =
        mediaQueryData!.padding.left + mediaQueryData!.padding.right;
    _safeAreaVertical =
        mediaQueryData!.padding.top + mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}
