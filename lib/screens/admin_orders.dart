import 'dart:convert';
import 'package:ass_login/model/images_model.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/categouries.dart';
import 'items_screen.dart';

class AdminOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminOrdersState();
  }
}

class AdminOrdersState extends State<AdminOrders> {
  List<Categoires> orderList = [];
  List<ImagesModel> imgList = [];

  @override
  void initState() {
    super.initState();

    getBanarImages();
  }

  var items = [
    'Processing ',
    'Shipped ',
    'Delivered'
  ];
  String dropdownvalue = 'Select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Orders"),
        backgroundColor: Colors.blueAccent.shade700,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 30,
            width: 30,
          ),
          Text("List of Orders"),
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
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),

        ],
      ),
    );
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
}
