import 'package:ass_login/screens/Login.dart';
import 'package:ass_login/screens/home_screen.dart';
import 'package:ass_login/screens/main_screen.dart';
import 'package:ass_login/screens/profile_screen.dart';
import 'package:ass_login/screens/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MoreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoreScreenState();
  }
}

class MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black, onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()));
        },
        ),
        backgroundColor: Colors.orangeAccent,
        actions:<Widget> [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none),

          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (
                ) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen()));
            }, child: Text("Profile")),
            TextButton(onPressed: () {}, child: Text("Orders")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
                },
                child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
