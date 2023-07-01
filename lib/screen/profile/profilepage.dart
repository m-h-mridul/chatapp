// // ignore_for_file: file_names, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable, prefer_const_constructors_in_immutables

// import 'package:potro/controller/imagecontroller.dart';
// import 'package:potro/helper/media.dart';
// import 'package:potro/model/userdata.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// class UserProfile extends StatelessWidget {
//   static String name = 'FirstUser';
//   UserProfile({Key? key}) : super(key: key);
//   ImageController imageController = Get.put(ImageController());
//   // ignore: non_constant_identifier_names
//   @override
//   Widget build(BuildContext context) {
//     imageController.imageGet();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: const Text("User Profile"),
//           backgroundColor: const Color(0xFF009688),
//         ),
//         body: Column(
//           children: [
//             SizedBox(
//               height: MediaQuerypage.smallSizeHeight! * 2,
//             ),
//             Obx(
//               () => Image.network(
//                 imageController.firebaseImageUrl.value,
//                 width: MediaQuerypage.screenWidth,
//                 height: MediaQuerypage.screenHeight! / 4,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                       child: CircularProgressIndicator(
//                     value: loadingProgress.expectedTotalBytes != null
//                         ? loadingProgress.cumulativeBytesLoaded /
//                             loadingProgress.expectedTotalBytes!.toDouble()
//                         : null,
//                   ));
//                 },
//                 errorBuilder: (BuildContext context, Object exception,
//                         StackTrace? stackTrace) =>
//                     Image(
//                   width: MediaQuerypage.screenWidth,
//                   height: MediaQuerypage.screenHeight! / 4,
//                   color: const Color(0xFF009688),
//                   image: const AssetImage(
//                     'assets/user.png',
//                   ),
//                 ),
//               ),
//             ),
//             Card(
//               child: Container(
//                 width: MediaQuerypage.screenWidth,
//                 height: MediaQuerypage.screenHeight! / 16,
//                 margin: const EdgeInsets.all(15.0),
//                 padding: const EdgeInsets.all(8.0),
//                 alignment: Alignment.centerLeft,
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                   // border: Border.all(color: Colors.blueAccent)
//                 ),
//                 child: Text(" Name :  ${UserData.firstUserName}",
//                     style: const TextStyle(fontSize: 20)),
//               ),
//             ),
//             Card(
//               child: Container(
//                 width: MediaQuerypage.screenWidth,
//                 height: MediaQuerypage.screenHeight! / 16,
//                 margin: const EdgeInsets.all(15.0),
//                 padding: const EdgeInsets.all(8.0),
//                 alignment: Alignment.centerLeft,
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                   // border: Border.all(color: Colors.blueAccent)
//                 ),
//                 child: Text(" Email :  ${UserData.email}",
//                     style: const TextStyle(fontSize: 20)),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
