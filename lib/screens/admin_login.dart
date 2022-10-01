import 'dart:convert';
import 'dart:math';
import 'package:ass_login/constants.dart';
import 'package:ass_login/screens/admin_main_screen.dart';
import 'package:ass_login/screens/main_screen.dart';
import 'package:ass_login/screens/signup.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AdminLogin extends StatefulWidget {
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
class _AdminLoginState extends State<AdminLogin> {
  bool showErrorEmail = false;
  bool showErrorPassword = false;
  bool _isChecked = false;
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
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Admin Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        buildEmail(),
                        SizedBox(
                          height: 50,
                        ),
                        buildPassword(),
                        SizedBox(
                          height: 10,
                        ),
                        buildRememberMe(),
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
  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailTextEditingController.text);
        prefs.setString('password', passwordTextEditingController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }
  Widget buildRememberMe() {
    return Row(
      children: [
        Checkbox(
            activeColor: Color(0xff00C8E8),
            value: _isChecked,
            // onChanged: _handleRemeberme(_isChecked)) ,
            onChanged: (bool? value) {
              _handleRemeberme(value!);
            }),
        //SizedBox(width: 10.0),
        Text("Remember Me", style: TextStyle(color: Color(0xff646464), fontSize: 15,fontFamily: 'Rubic')),
      ],);


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
            MaterialPageRoute(builder: (BuildContext context) => AdminMainScreen()));
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


