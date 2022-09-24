import 'dart:async';
import 'package:ass_login/screens/Login.dart';
import 'package:ass_login/screens/login_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';
import 'map_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Women Accessories!"),

      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkUserIsLogin();
  }
  checkUserIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(ConstantValue.ID) ?? "";

    if (userId == "") {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Login())));
    } else {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MainScreen())));
    }
  }
}
