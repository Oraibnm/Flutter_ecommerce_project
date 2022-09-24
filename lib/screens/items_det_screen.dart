import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/images_model.dart';
import 'cart_screen.dart';

class ItemDetScreen extends StatefulWidget {
  var id ;
  var name ;
  var price ;
  var des;

  ItemDetScreen(this.id , this.name, this.price, this.des);
  @override
  State<StatefulWidget> createState() {
    return ItemDetScreenState(id , name , price, des);
  }
}

class ItemDetScreenState extends State<ItemDetScreen>{
  var id ;
  var name ;
  var price ;
  var des ;
  ItemDetScreenState(this.id , this.name, this.price, this.des);
  List<Images> imgList = [
    Images(1,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    Images(2,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    Images(3,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    Images(4,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(itemBuilder: (context, index) {
                return Image.network(imgList[index].image);
              }
              ),
            ),
            Text(name,
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,),),
            Text('$price' ,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
            ),
            Text(des ,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),

            )
          ],
        ),
      ),
      bottomNavigationBar:
      TextButton(onPressed: () {
      }, child: TextButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title:Text ("Amazing items") ,
              content: Text("Whate Do You Want to Do ?"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                    child: Text("View Cart")),
                TextButton(onPressed: () {
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
      ),

    );
  }
}