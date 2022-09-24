import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cart_model.dart';



class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  List<CartModel> cartList = [
    CartModel(1, "item 1", 25, 3,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    CartModel(2, "item 2", 25, 3,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    CartModel(3, "item 3", 25, 3,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
    CartModel(4, "item 4", 25, 3,
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.orangeAccent,
        actions:<Widget> [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none),

          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                      cartList[index].image,
                      width: 150,
                      height: 100,
                    ),
                    Column(
                      children: [
                        Text(
                          cartList[index].name,
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(cartList[index].priec.toString())
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          if (cartList[index].count != 1) {
                            cartList[index].count = cartList[index].count - 1;
                          } else {
                            cartList.removeAt(index);
                          }
                          setState(() {});
                        },
                        child: Text("-",
                            style:
                                TextStyle(fontSize: 30, color: Colors.black)),
                      ),
                    ),
                    Text(cartList[index].count.toString()),
                    IconButton(
                      onPressed: () {
                        cartList[index].count = cartList[index].count + 1;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.add,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: cartList.length,
      ),
      bottomNavigationBar: TextButton(onPressed: () {}, child: Text("Next")),
    );
  }
}
