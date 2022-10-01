import 'dart:convert';

import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/images_model.dart';
import 'cart_screen.dart';

class ItemDetScreen extends StatefulWidget {
  var id;

  var name;

  var price;

  var des;

  ItemDetScreen(this.id, this.name, this.price, this.des);

  @override
  State<StatefulWidget> createState() {
    return ItemDetScreenState(id, name, price, des);
  }
}

class ItemDetScreenState extends State<ItemDetScreen> {
  var id;

  var name;

  var price;

  var des;

  ItemDetScreenState(this.id, this.name, this.price, this.des);

  List<ImagesModel> imgList = [];

  @override
  void initState() {
    super.initState();
    getItemImages();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(

                  itemCount: imgList.length,
                  itemBuilder: (context, index) {
                    return Image.network(imgList[index].image);
                  }),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Text(
              '$price',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            Text(
              des,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Amazing items"),
                  content: Text("Whate Do You Want to Do ?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        },
                        child: Text("View Cart")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Con Shopping"))
                  ],
                );
              });
        },
        child: Text("Add To Cart"),
      ),
    );
  }

  Future getItemImages() async {
    final response = await http.post(
        Uri.parse("${ConstantValue.URL}getItemImages.php"),
        body: {"Id_items": id});

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var images = jsonBody["Images"];
      for (Map i in images) {
        imgList.add(ImagesModel(i["Id"], i["Image"]));
      }
    }
    setState(() {});
  }

  //AddTo cart and call befor dialog
}
