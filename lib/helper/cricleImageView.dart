import 'package:flutter/material.dart';


// imageviewForProfile(String secondUserImage) {
//   return Image.network(
//     secondUserImage,
//     width: MediaQuerypage.smallSizeWidth! * 11,
//     height: MediaQuerypage.smallSizeHeight! * 4,
//     loadingBuilder:
//         (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//       if (loadingProgress == null) return child;
//       return Center(
//           child: CircularProgressIndicator(
//         value: loadingProgress.expectedTotalBytes != null
//             ? loadingProgress.cumulativeBytesLoaded /
//                 loadingProgress.expectedTotalBytes!.toDouble()
//             : null,
//       ));
//     },
//     errorBuilder:
//         (BuildContext context, Object exception, StackTrace? stackTrace) =>
//             Image(
//       width: MediaQuerypage.smallSizeWidth! * 11,
//       height: MediaQuerypage.smallSizeHeight! * 4,
//       color: Colors.amber,
//       image: const AssetImage(
//         'assets/user.png',
//       ),
//     ),
//   );
// }

imageviewForProfile(String secondUserImage) {
  return CircleAvatar(
    backgroundColor: Colors.white70,
    backgroundImage: NetworkImage(secondUserImage),
  );
}
