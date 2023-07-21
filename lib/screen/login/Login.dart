// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, unnecessary_null_comparison, must_be_immutable, non_constant_identifier_names, duplicate_ignore, unused_field

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:potro/Service/Login.dart';
import 'package:flutter/material.dart';
import '../../helper/media.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatelessWidget {
  static String name = '/Login';
  Login({Key? key}) : super(key: key);

  // variable
  TextEditingController c_email = TextEditingController();
  TextEditingController c_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 20));
    const BorderRadius borderRadius = BorderRadius.all(
      Radius.circular(12),
    );
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  animation folder
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage('assets/message.png')),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                          color: Color(0xFFEF7822),
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      child: AnimatedTextKit(
                        // pause: Duration(seconds: 20),
                        animatedTexts: [
                          WavyAnimatedText('Messageing'),
                          WavyAnimatedText('Messageing'),
                          WavyAnimatedText('Messageing'),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
                // buttom ..............
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 12.0),
                  child: TextField(
                    controller: c_email,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: borderRadius,
                      ),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 12.0),
                  child: TextField(
                    controller: c_password,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: borderRadius,
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuerypage.screenHeight! / 14,
                  width: MediaQuerypage.screenWidth!,
                  child: ElevatedButton(
                    style: style,
                    onPressed: () async {
                      print("login working .....");
                      SpinKitRotatingCircle(
                        color: Colors.white,
                        size: 50.0,
                      );
                      loginButton(c_email.text.toString().trim(),
                          c_password.text.toString().trim(), context);
                    },
                    child: const Text('Login'),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
