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
}
