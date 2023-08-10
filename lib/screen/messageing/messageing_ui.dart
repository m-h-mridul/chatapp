// ignore_for_file: avoid_print, unrelated_type_equality_checks, camel_case_types, prefer_const_constructors_in_immutables, prefer_is_empty, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:get/get.dart';
import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/controller/notificationcontroller.dart';
import 'package:potro/model/userdata.dart';
import 'package:flutter/material.dart';
import '../../helper/media.dart';
import 'helperwidget/bottomView.dart';
import '../../helper/cricleImageView.dart';
import 'helperwidget/messageview.dart';

class Messageing_ui extends StatelessWidget {
  static String name = "/Messageing ui";
  Messageing_ui({Key? key}) : super(key: key);
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 16));

    return Scaffold(
      appBar: appbarView(context),
      body: Padding(
        padding: EdgeInsets.only(
            left: MediaQuerypage.safeBlockVertical!,
            right: MediaQuerypage.safeBlockVertical!,
            bottom: MediaQuerypage.safeBlockHorizontal! * 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            messageView(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 10.0, left: 0.0),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: messageController.text.isEmpty
                            ? IconButton(
                                onPressed: () {
                                  settingModalBottomSheet(context);
                                },
                                icon: Icon(
                                  Icons.file_present,
                                  color: Colors.grey,
                                  size: MediaQuerypage.pixels! * 13,
                                ),
                              )
                            : null,
                        label: const Text("types messages",
                            style: TextStyle(color: Colors.teal)),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.teal, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      controller: messageController,
                      onChanged: (value) {},
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuerypage.screenHeight! / 18,
                  width: MediaQuerypage.screenWidth! / 5,
                  child: ElevatedButton(
                    style: style,
                    onPressed: () async {
                      await NotificationService.notificationSent(
                          token: UserData.secondUserToken.value,
                          text: messageController.text.toString(),
                          title: UserData.secondUserName);
                      await Messagedatabase()
                          .messagesent(messageController.text.toString());
                      messageController.clear();
                    },
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbarView(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          }),
      centerTitle: true,
      title: Column(
        children: [
          Text(UserData.secondUserName, style: const TextStyle(fontSize: 20)),
          Text(UserData.secondUserActiveTime.toString(),
              style: const TextStyle(fontSize: 14)),
        ],
      ),
      backgroundColor: const Color(0xFF009688),
      actions: [
        Obx(() => imageviewForProfile(UserData.secondUserImage.value)),
        SizedBox(
          width: MediaQuerypage.smallSizeWidth! * 3,
        )
      ],
    );
  }
}
