import 'dart:convert';
import 'package:path/path.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';
import 'main_screen.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState()=> _signupState();

}
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController confPasswordTextEditingController = TextEditingController();
TextEditingController nameTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
class _signupState extends State<signup> {

  bool showErrorName = false;
  bool showErrorPhone = false;
  bool showErrorConPassword = false;
  bool showErrorEmail = false;
  bool showErrorPassword = false;
  bool notShowPassword = true;
  bool notShowConPassword = true;

  bool sec = true;
  var visable = Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB2DFDB),
                      Color(0xFFE0F7FA),
                      Color(0xFFFFEBEE),
                      Color(0xFFFFEBEE),
                      Color(0xFFFFEBEE),
                      Color(0xFFF1F8E9),
                      Color(0xFFFFEBEE),
                      Color(0xFFE8F5E9),
                      Color(0xFFB3E5FC),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        buildName(),
                        SizedBox(
                          height:15,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 15,
                        ),
                        buildPhone(),
                        SizedBox(
                          height: 15,
                        ),
                        buildPassword(),
                        SizedBox(
                          height: 15,
                        ),
                        buildRePassword(),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: TextButton.styleFrom(backgroundColor: Colors.pinkAccent),
                            onPressed: () {
                              showErrorEmail = false;
                              showErrorName = false;
                              showErrorPhone = false;
                              showErrorPassword = false;
                              showErrorConPassword = false;
                              if (nameTextEditingController.text.isEmpty) {
                                showErrorName = true;
                              } else if (!isEmail(emailTextEditingController.text)) {
                                showErrorEmail = true;
                              } else if (phoneTextEditingController.text.isEmpty) {
                                showErrorPhone = true;
                              } else if (!validatePassword(
                                  passwordTextEditingController.text)) {
                                showErrorPassword = true;
                              } else if (passwordTextEditingController.text !=
                                  confPasswordTextEditingController.text) {
                                showErrorConPassword = true;
                              } else {
                                signUp();
                              }
                              setState(() {});
                            },
                            child: Text("SignUp")),
                        SizedBox(
                          height: 15,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                               child: Text("Go Back ", style: TextStyle(

                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontWeight:FontWeight.bold,
                                    decoration: TextDecoration.underline
                                ),)

                            )
                          ],
                        ),




                        ]),
                    ),
                  ),
                ),
            ], ),
          ),
        ),

    );
  }
  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text(
          "Name",
          style: TextStyle(
              color: Colors.pink[900],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextFormField(
            controller: nameTextEditingController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xff4c5166),
                ),
                hintText:"Enter Your Name",
                hintStyle: TextStyle(color: Colors.black38),
          ),
        ),
        )],
    );
  }
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
              color: Colors.pink[900],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextFormField(
            controller: emailTextEditingController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff4c5166),
                ),
                hintText: "demo@demo.com",
                hintStyle: TextStyle(color: Colors.black38),
                errorText: showErrorEmail ? "Please Enter valid email" : null),
          ),

          // validator: (value) {
          //   if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
          //     return 'Invalid Email';
          //   }
          //   return null;
          // },
        ),
      ],
    );
  }
  Widget buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone",
          style: TextStyle(
              color: Colors.pink[900],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xffebefff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ]),
          child: TextFormField(
            controller: phoneTextEditingController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Color(0xff4c5166),
                ),
                hintText: "059*******",
                hintStyle: TextStyle(color: Colors.black38),
          ),


        ),
        )],
    );
  }
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
              color: Colors.pink[900],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 60,
          child: TextField(
            controller: passwordTextEditingController,
            obscureText: sec,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Color(0xff4c5166),
                ),
                hintText: "QWEr!@#4",
                hintStyle: TextStyle(color: Colors.black38),
                errorText: showErrorPassword ? "Please Enter valid password" : null),
          ),
        ),
      ],
    );
  }
  Widget buildRePassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Re Password",
          style: TextStyle(
              color: Colors.pink[900],
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          height: 60,
          child: TextField(
            controller: confPasswordTextEditingController,
            obscureText: sec,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Color(0xff4c5166),
                ),
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: Colors.black38),
                errorText: showErrorConPassword
                    ? "Password not match"
                    : null),
          ),
        ),
      ],
    );
  }
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Future signUp() async {
    final response = await http.post(
      Uri.parse("${ConstantValue.URL}SignUp.php"),
      body: {
        'Email': emailTextEditingController.text, // parm1
        'Password': passwordTextEditingController.text, // parm2
        'Name': nameTextEditingController.text, // parm3
        'Phone': phoneTextEditingController.text, // parm4
      },
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody['result'];
      if (result) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(ConstantValue.ID, jsonBody["Id"]);
        await prefs.setString(ConstantValue.NAME, jsonBody["Name"]);
        await prefs.setString(ConstantValue.PHONE, jsonBody["Phone"]);
        await prefs.setString(ConstantValue.EMAIL, jsonBody["Email"]);
        Navigator.of(this.context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
      } else {
        showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text("Worrning !!!!!"),
              content: Text(jsonBody['msg']),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            );
          },
        );
      }
    }
  }

}



