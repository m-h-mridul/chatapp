// ignore_for_file: avoid_print, unrelated_type_equality_checks, camel_case_types, prefer_const_constructors_in_immutables, prefer_is_empty, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:chatapp/Service/Messagedatabase.dart';
import 'package:chatapp/model/userdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../media.dart';
import 'Chatui.dart';


class Messageing_ui extends StatelessWidget {
  static String name = "Messageing ui";
  Messageing_ui({Key? key}) : super(key: key);
  // text editor varibale
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // bottom style
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 16));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Text(UserData.secondUserName,
              style: const TextStyle(fontSize: 20)),
          backgroundColor: const Color(0xFF009688),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //firebase data get
              const Messageui(),
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
}
