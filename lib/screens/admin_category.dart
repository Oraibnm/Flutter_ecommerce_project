import 'dart:convert';
import 'package:ass_login/model/images_model.dart';
import 'package:ass_login/screens/items_det_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/categouries.dart';
import 'items_screen.dart';

class AdminCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminCategoryState();
  }
}

class AdminCategoryState extends State<AdminCategory> {
  List<Categoires> cateList = [];
  List<ImagesModel> imgList = [];

  @override
  void initState() {
    super.initState();
    getCategories();
    getBanarImages();
  }

  TextEditingController NameController = TextEditingController();
  TextEditingController ImageController = TextEditingController();
  var items = [
    'Active',
    'Deactivate'
  ];
  String dropdownvalue = 'Select';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        backgroundColor: Colors.blueAccent.shade700,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 30,
            width: 30,
          ),
          TextField(
            controller: NameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 120),
                  hintText: "Enter Category Name",
                  hintStyle: TextStyle(color: Colors.black38),
            ),

          ),
          TextField(
            controller: NameController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 120),
              hintText: "Upload Category Image",
              hintStyle: TextStyle(color: Colors.black38),
            ),

          ),
          SizedBox(
            height: 30,
            width: 30,
          ),
          DropdownButton(

            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
          SizedBox(
            height: 30,
            width: 30,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.blueAccent.shade700),
            onPressed: () {

              setState(() {});
            },
            child: Text("Add"),
          ),
          SizedBox(
            height: 30,
          ),

        ],
      ),
    );
  }


  Future getCategories() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.URL}GetCategories.php"),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody["categories"];
      for (Map i in categories) {
        cateList.add(Categoires(i["Id"], i["Name"], i["Image"]));
      }
      setState(() {});
    }
  }

  Future getBanarImages() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.URL}GetBanarImages.php"),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var images = jsonBody["images"];
      for (Map i in images) {
        imgList.add(ImagesModel(i["Id"], i["Image"]));
      }
    }
    setState(() {});
  }

  Future AddCart() async {
    var request = http.MultipartRequest("POST", Uri.parse("AddCat.php"));
    var pic;
    request.fields['Name'] ="Test New Cat";
    request.fields['Id_statetype']="1";
    request.files.add(pic);
    var response = await request.send();
    var responsedata=await response.stream.toBytes();
    var responseString = String.fromCharCodes(responsedata);
    var jsonBody=jsonDecode(responseString);
    bool result = jsonBody['result'];
    print(result);

  }
}
