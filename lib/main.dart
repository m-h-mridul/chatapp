// ignore_for_file: prefer_const_constructors, unused_element

import 'package:get/route_manager.dart';
import 'package:potro/helper/callingname.dart';
import 'package:potro/helper/offlinestroage.dart';
import 'package:potro/screen/profile/profile.dart';
import 'package:potro/screen/login/Login.dart';
import 'package:potro/screen/home/home.dart';
import 'package:potro/screen/registation/registation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'model/userdata.dart';
import 'screen/Alluser/Alluser.dart';
import 'screen/messageing/messageing_ui.dart';

String cheakuserLogin = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OfflineStrogae offlineStrogae = OfflineStrogae.instance;
  await offlineStrogae.readyDatabase();
  cheakuserLogin = offlineStrogae.getdata(name: Callingname.userUid);
  if (cheakuserLogin != "not find") {
    UserData.userId = cheakuserLogin;
  }
  // for handing background notifiacaion
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// for flutter local notification
// channel that creat top of file
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

// firebase messageing notification for
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // remove status bar and change the icon view
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
    // when app is open the notification is show
    notificationshowonapp();
    // if app close then the app is open from notification
    whenappcloseappstart(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: cheakuserLogin != "not find" ? Alluser.name : MyHomePage.name,
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

whenappcloseappstart(BuildContext context) =>
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });

notificationshowonapp() =>
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

//for local notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// that is useing for background notification handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
