import 'dart:convert';
import 'package:ass_login/screens/map_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/cart_model.dart';


class CartScreen extends StatefulWidget {
  var fromMain;

  CartScreen(this.fromMain);

  @override
  State<StatefulWidget> createState() {
    return CartScreenState(fromMain);
  }
}

class CartScreenState extends State<CartScreen> {
  var fromMain;
  double totalPrice = 0;

  CartScreenState(this.fromMain);

  List<CartModel> cartList = [];

  var userId = '0';

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userId = preferences.getString(ConstantValue.ID)!;

    //  print(id);
    setState(() {
      userId = preferences.getString(ConstantValue.ID)!;
    });
    return userId;
  }

  Future fetchData() async{
    final http.Response response = await http.post(
        Uri.parse("${ConstantValue.URL}GetCart.php"),
        body: {
          "Id_users" : await getPref()
        }
    );

    if (response.statusCode != 200){
      throw Future.error('Request Error');
    }
    else{
      var jsonData = json.decode(response.body);
      // print(jsonData);
      try {
        getTotalPrice(jsonData);
        return jsonData;
      }
      catch(e){
        throw Future.error('Server Error');
      }
    }
  }

  deleteCart(cartId) async {
    final http.Response response = await http.post(
        Uri.parse("${ConstantValue.URL}deleteCart.php"),
        body: {
          "Id" : cartId.toString()
        }
    );
  }

  updateCount(cartId,count) async {
    final http.Response response = await http.post(
        Uri.parse("${ConstantValue.URL}UpdateCart.php"),
        body: {
          "Id" : cartId.toString(),
          "Count" : count.toString()
        }
    );
  }

  getTotalPrice(snapshot) {
    totalPrice = 0.0;
    for (int x = 0; x < snapshot['cart'].length; x++) {
      totalPrice = totalPrice + (snapshot['cart'][x]['Price'] * snapshot['cart'][x]['count']);
      //    print(totalPrice);
    }
    return totalPrice;
  }

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //totalPrice = 0;
    /*  for (int x = 0; x < cartList.length; x++) {
      totalPrice = totalPrice + (cartList[x].price * cartList[x].count);
    }*/
    return Scaffold(
      appBar: fromMain ? null : AppBar(),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: fromMain
                ? MediaQuery.of(context).size.height - 301
                : MediaQuery.of(context).size.height - 249,
            child:  FutureBuilder(
                future: fetchData(),
                builder: (context, AsyncSnapshot snapshot){
                  if (snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data['cart'].length,
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
                                    // cartList[index].image,
                                    snapshot.data['cart'][index]['HomeImage'].toString(),
                                    width: 150,
                                    height: 100,
                                    //   fit: BoxFit.fill,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        // cartList[index].name,
                                        snapshot.data['cart'][index]['Name'].toString(),
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Text(snapshot.data['cart'][index]['Price'].toString())
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                      onPressed: () async{
                                        /*if (cartList[index].count != 1) {
                                          cartList[index].count =
                                              cartList[index].count - 1;
                                        } else {
                                          cartList.removeAt(index);
                                        }*/
                                        if (snapshot.data['cart'][index]['count'] != 1) {
                                          var currentCount = snapshot.data['cart'][index]['count'] -1 ;

                                          await updateCount(snapshot.data['cart'][index]['Id'],currentCount);
                                          setState(() {});

                                        } else {
                                          // snapshot.data['cart'].removeAt(index);
                                          deleteCart(snapshot.data['cart'][index]['Id']);
                                          setState(() {});
                                        }
                                        // setState(() {});
                                      },
                                      child: Text("-",
                                          style: TextStyle(
                                              fontSize: 30, color: Colors.black)),
                                    ),
                                  ),
                                  Text(snapshot.data['cart'][index]['count'].toString()),
                                  IconButton(
                                    onPressed: () async{
                                      // cartList[index].count = cartList[index].count + 1;
                                      var currentCount = snapshot.data['cart'][index]['count'] + 1 ;

                                      await updateCount(snapshot.data['cart'][index]['Id'],currentCount);

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
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: TextButton(onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => MapScreen()));
        }, child: Text("Next")),
      ),
    );
  }
}
