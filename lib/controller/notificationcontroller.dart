import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  intalizenotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    notificationshowonapp();
  }

  intalizedlocalnotification(
      BuildContext context, RemoteMessage message) async {
    var andoriadNotificatinsetting =
        const AndroidInitializationSettings("@mipmap/icon_louncher");
    var iosnotficationintalized = const DarwinInitializationSettings();

    var intalizationSetting = InitializationSettings(
        android: andoriadNotificatinsetting, iOS: iosnotficationintalized);

    await flutterLocalNotificationsPlugin.initialize(intalizationSetting,
        onDidReceiveBackgroundNotificationResponse: (playload) {});
  }

  notificationshowonapp() {
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
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/icon_louncher',
            ),
            iOS: const DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true),
          ),
        );
      }
    });
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

  Future<String> getdeviceToken() async {
    String? token = await _messaging.getToken();
    return token!;
  }
}
