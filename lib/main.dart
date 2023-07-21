// ignore_for_file: prefer_const_constructors, unused_element

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/route_manager.dart';
import 'package:potro/helper/callingname.dart';
import 'package:potro/helper/offlinestroage.dart';
import 'package:potro/screen/profile/profile.dart';
import 'package:potro/screen/login/Login.dart';
import 'package:potro/screen/home/home.dart';
import 'package:potro/screen/registation/registation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller/notificationcontroller.dart';
import 'model/userdata.dart';
import 'screen/Alluser/Alluser.dart';
import 'screen/messageing/messageing_ui.dart';

String cheakuserLogin = '';
NotificationService _notificationService = NotificationService();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  OfflineStrogae offlineStrogae = OfflineStrogae.instance;
  await offlineStrogae.readyDatabase();

  cheakuserLogin = offlineStrogae.getdata(name: Callingname.userUid);
  if (cheakuserLogin != "not find") {
    UserData.userId = cheakuserLogin;
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await _notificationService.intalizenotification();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFFFFF),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _notificationService.whenappcloseappstart(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          cheakuserLogin != "not find" ? Alluser.name : MyHomePage.name,
      routes: {
        MyHomePage.name: (context) => const MyHomePage(),
        Login.name: (context) => Login(),
        Registation.name: (context) => Registation(),
        Alluser.name: (context) => Alluser(),
        Messageing_ui.name: (context) => Messageing_ui(),
        UserProfile.name: (context) => UserProfile(),
      },
    );
  }
}

@pragma('vm:entery-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
