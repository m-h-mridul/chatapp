import 'package:flutter/material.dart';
import 'package:potro/helper/media.dart';

pdfviewr(String value, bool view) {
  return Container(
    decoration: BoxDecoration(
       border: Border.all(color: const Color(0xFF909090)),
       borderRadius:BorderRadius.all(Radius.circular(10)),
    ),
    width: MediaQuerypage.screenWidth! * 0.5,
    height: MediaQuerypage.screenHeight! * 0.2,
    child: Column(
      children: [
        const Image(
          image: AssetImage(
            'assets/PDF.png',
          ),
        ),
        Text(
          'Pdf-viwer',
          style: TextStyle(
              color: Colors.black, fontSize: MediaQuerypage.textSize! * 16),
        ),
      ],
    ),
  );
}
