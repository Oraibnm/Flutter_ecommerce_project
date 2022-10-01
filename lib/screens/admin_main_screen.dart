import 'package:ass_login/screens/admin_category.dart';
import 'package:ass_login/screens/admin_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'more_screen.dart';

class AdminMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminMainScreenState();
  }
}

class AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backwardsCompatibility: false,
            backgroundColor: Colors.blueAccent.shade700,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.category_outlined)),
                Tab(icon: Icon(Icons.delivery_dining_outlined)),
                Tab(icon: Icon(Icons.supervised_user_circle_sharp)),
              ],
            ),
            title: const Text('Admin'),
          ),
          body: TabBarView(
            children: [Category(), Order(), Users()],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminProfile()));
                },
                child: const Icon(Icons.person),
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log out '),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget Category() {
    return Column(children: [
      Row(
        children: [
          SizedBox(
            width: 50,
            height: 70,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminCategory()));
              setState(() {});
            },
            child: Text("Add"),
          ),
          SizedBox(width: 20),
        ],
      ),
    ]);
  }

  Widget Order() {
    return Column(children: [
      Row(
        children: [
          SizedBox(
            width: 50,
            height: 70,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminCategory()));
              setState(() {});
            },
            child: Text(""),
          ),
          SizedBox(width: 20),
        ],
      ),
    ]);
  }

  Widget Users() {
    return Container(
      child: Text("Users"),
    );
  }
}
