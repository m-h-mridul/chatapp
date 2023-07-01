// ignore_for_file: avoid_print, unrelated_type_equality_checks, camel_case_types, prefer_const_constructors_in_immutables, prefer_is_empty, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:potro/Service/Messagedatabase.dart';
import 'package:potro/model/userdata.dart';
import 'package:flutter/material.dart';
import '../../Service/image.dart';
import '../../controller/messagecontroller.dart';
import '../../helper/media.dart';

class Messageing_ui extends StatelessWidget {
  static String name = "Messageing ui";
  Messageing_ui({Key? key}) : super(key: key);
  // text editor varibale
  TextEditingController messageController = TextEditingController();
  ImageController imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    // bottom style
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 16));

    // start build method
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Column(
            children: [
              Text(UserData.secondUserName,
                  style: const TextStyle(fontSize: 20)),
              Text(UserData.secondUserActiveTime.toString(),
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          backgroundColor: const Color(0xFF009688),
          actions: [
            Obx(() => imageview(UserData.secondUserImage.value)),
            SizedBox(
              width: MediaQuerypage.smallSizeWidth! * 3,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //firebase data get and show
              messageView(),
              Row(
                // /keyborad and button
                // for text to second user
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, right: 10.0, left: 0.0),
                      child: TextField(
                        decoration: InputDecoration(
                          label: const Text("types messages",
                              style: TextStyle(color: Colors.teal)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.teal, width: 2.0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        controller: messageController,
                        onChanged: (value) {
                          // messageText = value;
                        },
                        // decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuerypage.screenHeight! / 18,
                    width: MediaQuerypage.screenWidth! / 5,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () async {
                        // sent dta into forebase
                        // database on button click in
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
      ),
    );
  }

  messageView() {
    return Expanded(
      child: SingleChildScrollView(
        reverse: true,
        child: GetX<MessageController>(
            init: MessageController(),
            //initState:MessageController().messgaeget(),
            builder: (controller) => (controller.messagelist.isEmpty)
                ? const Center(
                    child: Text(
                      'Start Conversation',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.messagelist.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: (controller.messagelist[i].name ==
                                  UserData.firstUserName)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(controller.messagelist[i].name),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF009688),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0,
                                    bottom: 6.0,
                                    left: 12.0,
                                    right: 12.0),
                                child: Text(controller.messagelist[i].text,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white)),
                              ),
                            ),
                            Text(controller.messagelist[i].time,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    })),
      ),
    );
  }

  imageview(String secondUserImage) {
    return Image.network(
      secondUserImage,
      width: MediaQuerypage.screenWidth! / 10,
      height: MediaQuerypage.screenHeight! / 30,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
            child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!.toDouble()
              : null,
        ));
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              Image(
        width: MediaQuerypage.screenWidth! / 10,
        height: MediaQuerypage.screenHeight! / 30,
        color: Colors.amber,
        image: const AssetImage(
          'assets/user.png',
        ),
      ),
    );
  }
}
