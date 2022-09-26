import 'dart:convert';

import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model.dart';



class CartScreen extends StatefulWidget {
  var userId;

  @override
  State<StatefulWidget> createState() {
    return CartScreenState(userId);
  }
}

class CartScreenState extends State<CartScreen> {
  var userId;
  CartScreenState(this.userId);
  List<CartModel> cartList = [];

  @override
  void initState() {
    super.initState();
    GetCart();
  }

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

  Future GetCart() async {
    final response = await http.post(
        Uri.parse("${ConstantValue.URL}GetCart.php"),
        body: {"Id_users": userId }
    );
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        var cart = jsonBody['cart'];

        for (Map i in cart) {
          cartList.add(CartModel(
               i["Id"], i["Name"], i["Price"], i["count"], i["HomeImage"]));
        }
        setState(() {});
      }

    }
  }
