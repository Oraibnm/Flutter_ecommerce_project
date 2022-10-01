import 'dart:convert';

import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  var userId = '0';
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(ConstantValue.ID)!;
    setState(() {
      userId = preferences.getString(ConstantValue.ID)!;
    });
    return userId;
  }

  Future fetchData() async{
    final http.Response response = await http.post(
        Uri.parse("${ConstantValue.URL}GetOrders.php"),
        body: {
          "Id_users" : await getPref()
        }
    );

    if (response.statusCode != 200){
      throw Future.error('Request Error');
    }
    else{
      var jsonData = json.decode(response.body);
      print(jsonData);
      try {
        return jsonData;
      }
      catch(e){
        throw Future.error('Server Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20,top: 10),
            child: const Text("My Orders: ", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          FutureBuilder(
              future: fetchData(),
              builder: (context, AsyncSnapshot snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['orders'].length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        isThreeLine: true,
                        leading: const Icon(Icons.shopping_cart),
                        title: Text("${snapshot.data['orders'][index]['Note'].toString()}"),
                        subtitle: Text("Order Num : ${snapshot.data['orders'][index]['Id'].toString()}"),
                        trailing: Column(
                          children: [
                            Text("Total Price: " , style: TextStyle(color: Colors.black)),
                            Text(snapshot.data['orders'][index]['TotalPrice'].toString() , style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Center(child: Text("Error " + snapshot.error.toString()));
                }
                else{
                  return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()
                  );
                }
              }
          ),
        ],
      ),
    );
  }
}
