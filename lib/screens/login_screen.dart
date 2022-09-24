import 'package:ass_login/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
 static String id ='Login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kmaincolor,
      body:ListView(
        children: <Widget> [
        Container(
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/icons/icons8-accessories-64.png'),
              ),
              Positioned(
                bottom: 0,
                  child:  Text('Women Accessories!', style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20
              ),))



            ],
          ),
        )
          
        ],
      ) ,


    );
  }
}
