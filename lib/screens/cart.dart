import 'dart:convert';
import 'package:ass_login/screens/order_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model.dart';

class CartScreen extends StatefulWidget {
  var fromMain;

  CartScreen(this.fromMain);

  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  String Id = '';
  int totalPrice = 0;
  List<CartModel> cartList = [];

  @override
  void initState() {
    super.initState();
    addOrder();
    getId();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:Container(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
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
                                    cartList[index].count =
                                        cartList[index].count - 1;
                                  } else {
                                    cartList.removeAt(index);
                                  }

                                  setState(() {});
                                },
                                child: Text("-",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              padding: EdgeInsets.all(10),
              child: Row(
                  children: [Text("Total Price"), Text("$totalPrice")],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: TextButton(onPressed: () {
          setState(() async{
          await  addOrder();
          });

        }, child: Text("Add Order")),
      ),
    );
  }
  Future addOrder() async {
    await getId();
    Response response = await http.post(
        Uri.parse("${ConstantValue.URL}AddOrder.php"),
        body: {
          "Id_users": Id,
          "TotalPrice": totalPrice.toString(),
          "Longitude": "",
          "Latitude": "",
          "Note": "",

        });

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
      setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (_)=> OrdersScreen()));
    }else {
      print("error");
    }
  }

  Future getId()async{
    final prefs = await SharedPreferences.getInstance();
    Id = prefs.getString("Id")!;
    setState(() {

    });
  }

}