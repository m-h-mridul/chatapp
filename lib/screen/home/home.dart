// ignore_for_file: unused_field, unused_local_variable, use_build_context_synchronously

import 'package:potro/Service/GoogleLogin.dart';
import 'package:potro/Service/faceboo_login.dart';
import 'package:potro/screen/registation/registation.dart';
import 'package:flutter/material.dart';
import '../../helper/media.dart';

import '../Alluser/Alluser.dart';
import '../login/Login.dart';

class MyHomePage extends StatefulWidget {
  static String name = '/MyHomePage';
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String name = 'MyHomePage';
  @override
  Widget build(BuildContext context) {
    MediaQuerypage.init(context);
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(fontSize: 25));
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage('assets/m1.jpg')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuerypage.screenHeight! / 14,
                width: MediaQuerypage.screenWidth!,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.pushNamed(context, Login.name);
                  },
                  child: const Text('Login'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuerypage.screenHeight! / 14,
                width: MediaQuerypage.screenWidth!,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.pushNamed(context, Registation.name);
                  },
                  child: const Text('Registation'),
                ),
              ),
            ),
            const Text('---------------------- OR ------------------------'),
            // /google buttom for registation
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage: const AssetImage('assets/google.png'),
                      maxRadius: MediaQuerypage.smallSizeWidth! * 7,
                    ),
                    onTap: () async {
                      // call google to creat an account
                      //in firebase
                      await signInWithGoogle();
                      // then goto the app
                      Navigator.pushNamedAndRemoveUntil(context, Alluser.name,
                          (Route<dynamic> route) => false);
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      // call google to creat an account
                      //in firebase
                      await facebok_login();
                      // then goto the app
                      Navigator.pushNamedAndRemoveUntil(context, Alluser.name,
                          (Route<dynamic> route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/facebook.png'),
                        maxRadius: MediaQuerypage.smallSizeWidth! * 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
