import 'package:ass_login/screens/items_det_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    Items(
        1,
        "item 1",
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        20,
        "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    Items(
        2,
        "item 2",
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        20,
        "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    Items(
        3,
        "item 3",
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        20,
        "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
    Items(
        4,
        "item 4",
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        20,
        "sdfsjdkdsfhdsjkfhdsjkfhsdkjhsdkjfhdsjkfhdskjfhsdjkfhdsjkhsdfjk"),
  ];

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
}
