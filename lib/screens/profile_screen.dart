import 'dart:io';

import 'package:ass_login/screens/more_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController confPasswordTextEditingController = TextEditingController();
TextEditingController nameTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();
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
class ProfileScreenState extends State<ProfileScreen> {
  late File? _image = null;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MoreScreen()));
            },
          ),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(children: [
              Text(
                "Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500 ),
                // textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Upload Image",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500 ),
                textAlign: TextAlign.center,

              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: _image != null
                    ? Image.file(_image!)
                    : IconButton(
                        onPressed: () {
                          showOptionChooser();
                        },
                        icon: Icon(Icons.camera)),
              ),
              SizedBox(
                height: 15,
              ),
              buildName(),
              SizedBox(
                height: 15,
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
              ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => MoreScreen()));
                  },
                  child: Text("SAVE")),

            ]),
          ),
        ));
  }

  getImage(ImageSource imageSource) async {
    PickedFile? imageFile = await picker.getImage(source: imageSource);
    if (imageFile == null) return;
    setState(
      () {
        _image = File(imageFile.path);
      },
    );
  }

  void showOptionChooser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Please Choose"),
          actions: [
            TextButton(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                getImage(ImageSource.gallery);
              },
            )
          ],
        );
      },
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
}
