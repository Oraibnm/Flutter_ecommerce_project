import 'dart:convert';
import 'dart:math';
import 'package:ass_login/constants.dart';
import 'package:ass_login/screens/main_screen.dart';
import 'package:ass_login/screens/signup.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
class _LoginState extends State<Login> {

  bool showErrorEmail = false;
  bool showErrorPassword = false;

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
      backgroundColor: Kmaincolor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Color(0xFFB2DFDB),
                      // Color(0xFFE0F7FA),
                      // Color(0xFFFFEBEE),
                      // Color(0xFFFFEBEE),
                      // Color(0xFFFFEBEE),
                      // Color(0xFFF1F8E9),
                      // Color(0xFFFFEBEE),
                      // Color(0xFFE8F5E9),
                      // Color(0xFFB3E5FC),


                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 50,
                        ),
                        buildPassword(),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.pinkAccent),
                          onPressed: () {
                            showErrorEmail = false;
                            showErrorPassword = false;
                            if (!isEmail(emailTextEditingController.text)) {
                              showErrorEmail = true;
                            } else if (!validatePassword(
                                passwordTextEditingController.text)) {
                              showErrorPassword = true;
                            } else {
                              login();
                            }
                            setState(() {});
                          },
                          child: Text("Login"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("If you haven't Account ! Sign up :)"),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.pinkAccent),
                          onPressed: () {
                            if (isEmail(emailTextEditingController.text)) {
                              showErrorEmail = true;
                            } else if (!validatePassword (passwordTextEditingController.text)){
                              showErrorPassword = true;
                            }
                            else {
                              login();
                            }
                            setState(() {

                            });
                            if (validateStructure(
                                passwordTextEditingController.text)) {
                              showErrorPassword = true;
                            } else {
                              // showErrorPassword = true;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => signup()));
                            }

                            setState(() {});
                          },
                          child: Text("Sign Up"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildFacebook(),
                            buildGoogle(),
                            buildTwitter()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          child:
          TextFormField(
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

          // validator: (val ue) {
          //   if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.')){
          //     return 'Invalid Email';
          //   }
          //   return null;
          // },
        ),
      ],
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


  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Widget buildFacebook() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/facebook.png"),
    );
  }

  Widget buildGoogle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/search.png"),
    );
  }

  Widget buildTwitter() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/twitter.png"),
    );
  }

  Future login() async {
    final response = await http.post(
        Uri.parse("${ConstantValue.URL}login.php"),
        body: {
          'Email':emailTextEditingController.text,
          'Password':passwordTextEditingController.text,
        }
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody['result'];
      if (result){
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(ConstantValue.ID, jsonBody["Id"]);
        await prefs.setString(ConstantValue.NAME, jsonBody["Name"]);
        await prefs.setString(ConstantValue.PHONE, jsonBody["Phone"]);
        await prefs.setString(ConstantValue.EMAIL, jsonBody["Email"]);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
      }
      else{
        showDialog(
            context:context,
            builder: (context){

              return AlertDialog(
                title: Text("Worrning !!"),
                content: Text(jsonBody['msg']),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"))
                ],
              );

            });

      }
    }
  }
}


