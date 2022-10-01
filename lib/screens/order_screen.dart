import 'dart:convert';

import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String Id = '';
  List ordersList = [];
  var total;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Container(
            child: ListView(
              shrinkWrap: true,
              // itemBuilder: ((context, index) => Row(
              // children: [
              // SizedBox(width: 25,),
              // Text(ordersList[index]["TotalPrice"]),
              // ],
              // )
              // ),
              //   itemCount:0,
            ),
          )),
    );
  }

  Future getOrders() async {
    await getId();
    final response =
        await http.post(Uri.parse("${ConstantValue.URL}getOrders.php"), body: {
      "Id_users": 55.toString(),
    });
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      for (var element in jsonBody['order']) {
        ordersList.add(element);
      }
      print(ordersList);
      setState(() {});
    } else {
      print("exception");
    }
  }

  Future getId() async {
    final prefs = await SharedPreferences.getInstance();
    Id = prefs.getString("Id")!;
    setState(() {});
  }
}
