import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../themes.dart';
import 'home.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  static String id = 'splashPage';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // CustomUser? _user;
  Future<void> navigate() async {
    final _user = FirebaseAuth.instance.currentUser;
    return Future.delayed(Duration(milliseconds: 100), () async {
      if (_user == null)
        Navigator.popAndPushNamed(context, LoginPage.id);
      else {
        Navigator.popAndPushNamed(context, HomePage.id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) => navigate();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: kBackgroundImage,
        ),
        child: Image.asset(
          'assets/images/EdMission200.png',
          height: 100,
          width: 100,
          fit: BoxFit.scaleDown,
        ),
      ),
    ));
  }
}
