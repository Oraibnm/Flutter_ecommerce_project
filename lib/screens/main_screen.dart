import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'more_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  Widget _widget = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

      ),
      body: _widget,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
        ],
        onTap: onTap,
        currentIndex: currentIndex,
      ),
    );
  }

  void onTap(int x) {
    currentIndex = x;
    if (currentIndex == 0) {
      _widget = HomePage();
    } else if (currentIndex == 1) {
      _widget = CartScreen();
    } else {
      _widget = MoreScreen();
    }
    setState(() {});
  }
}
