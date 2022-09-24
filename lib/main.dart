import 'package:ass_login/screens/home_screen.dart';
import 'package:ass_login/screens/signup.dart';
import 'package:ass_login/screens/splash_page.dart';
import 'package:flutter/material.dart';

import 'screens/Login.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Women Accessories!',

      theme: ThemeData(
          primaryColorLight: Colors.deepOrange,
      ),
      home:SplashPage(),
    );
  }
}


