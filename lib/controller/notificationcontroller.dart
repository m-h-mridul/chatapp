import 'dart:convert';
import 'package:http/http.dart' as http;
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

   static notificationSent({String? token, String? text, String? title}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAShLn-84:APA91bGtD5ovypO9WxsO6UYGcVwk9YACRU_5AdlvAprQQ7GKY3zEH4HNUsbsswK-j220aj6Lmlrxejftv6MDsqCVJh-4bNXNzxArCQ0v0YkfGsJZpcH8nQQMtnKw0P0Obr4MvJSV3Hrr',
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': text,
            'title': title,
          },
          "notification": <String, dynamic>{
            "title": title,
            "body": text,
            "android_channel_id": "dhfood"
          },
          "to": token,
        }),
      );
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
