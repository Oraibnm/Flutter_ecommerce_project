import 'dart:convert';

import 'package:ass_login/screens/items_det_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/items_model.dart';

class ItemsScreen extends StatefulWidget {
  var categId;
  var categName;

  ItemsScreen(this.categId, this.categName);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ItemsScreenState(categId, categName);
  }
}

class ItemsScreenState extends State<ItemsScreen> {
  var categId;
  var categName;

  ItemsScreenState(this.categId, this.categName);

  List<Items> itemsList = [
    // Items(
    //     1,
    //     "item 1",
    //     "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    //     20,
    //     "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    // Items(
    //     2,
    //     "item 2",
    //     "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    //     20,
    //     "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    // Items(
    //     3,
    //     "item 3",
    //     "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    //     20,
    //     "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    // Items(
    //     4,
    //     "item 4",
    //     "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    //     20,
    //     "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
  ];

  @override
  void initState() {
    super.initState();
    GetItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categName),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return InkWell(onTap:() {
          Navigator.push(context, MaterialPageRoute(builder:(context)=> ItemDetScreen(
            itemsList[index].id,
            itemsList[index].name,
            itemsList[index].price,
            itemsList[index].des)),
    );
    },
              child: Column(
                children: [
                  Image.network(itemsList[index].image),
                  Text(itemsList[index].name),
                  Text(itemsList[index].price.toString())
                ],
              ));
        },
        itemCount: itemsList.length,
      ),
    );
  }

  Future GetItems() async {
    final response = await http.post(
        Uri.parse("${ConstantValue.URL}GetItems.php"),
        body: {"Id_categories": categId});
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];

      for (Map i in items) {
        itemsList.add(Items(
            i["Id"], i["Name"], i["HomeImage"], i["Price"], i["Des"]));
      }
      setState(() {});
    }
  }
}
