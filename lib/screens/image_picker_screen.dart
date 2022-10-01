import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImagePickerScreenState();
  }
}

class ImagePickerScreenState extends State<ImagePickerScreen> {
  late File? _image = null;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: _image != null
                ? Image.file(_image!)
                : IconButton(
                    onPressed: () {
                      showOptionChooser();
                    },
                    icon: Icon(Icons.camera))));
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

  // Future addCat () async {
  //  var request = http.MultiparRequest("POST" ,Uri.parse('http://192.168.1.2:8080/firstflutterproject/AddCat.php'));
  //  var pic = await http.MultiparFile.fromPath
  // }
}
