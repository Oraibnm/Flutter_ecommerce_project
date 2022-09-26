import 'dart:convert';
import 'package:ass_login/model/images_model.dart';
import 'package:ass_login/screens/items_det_screen.dart';
import 'package:ass_login/screens/utl/constant_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/categouries.dart';
import 'items_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Categoires> cateList = [];
  List<ImagesModel> imgList = [];

  @override
  void initState() {
    super.initState();
    getCategories();
    getBanarImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 15,
          // ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.20) - 10,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: cateList.length,
                itemBuilder: (context, index) {
                  return Image.network(cateList[index].image ,
                    height: ((MediaQuery.of(context).size.height * .75) / 3),
                    width: MediaQuery.of(context).size.width/3,);
                }),
          ),
          SizedBox(
            height: 30,
          ),

          Text('Categories',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.70) - 151,
            child: GridView.builder(
              itemCount: cateList.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemsScreen(
                              cateList[index].id, cateList[index].name)),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(

                        cateList[index].image,
                        height:
                            ((MediaQuery.of(context).size.height * .75) / 3),
                        width: MediaQuery.of(context).size.width/3,
                        fit: BoxFit.fill,
                      ),
                      Text(cateList[index].name)
                    ],
                  ),
                );
              },
            ),
          )
          // neck_chain(context),
          // rings(context),
          // brecelet(context),

          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: (MediaQuery.of(context).size.height * 0.75) - 200,
          //   child: GridView.builder(
          //       itemCount: cateList.length,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2),
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => ItemsScreen(
          //                       cateList[index].id, cateList[index].name)),
          //             );
          //           },
          //           child: Column(
          //             children: [
          //               Image.network(cateList[index].image),
          //               Text(cateList[index].name)
          //             ],
          //           ),
          //         );
          //       }),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
        ],
      ),
    );
  }

  Widget neck_chain(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
              child: Text('Neck Chain',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center)),
        ),
        color: Color(0xFFFFE0B2),
      ),
    );
  }

  Widget rings(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
              child: Text('Rings',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center)),
        ),
        color: Color(0xFFFFE0B2),
      ),
    );
  }

  Widget brecelet(BuildContext context) {
    return const Center(
        child: Card(
      child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
              child: Text('Brecelet',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center))),
      color: Color(0xFFFFE0B2),
    ));
  }

  Future getCategories() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.URL}GetCategories.php"),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody["categories"];
      for (Map i in categories) {
        cateList.add(Categoires(i["Id"], i["Name"], i["Image"]));
      }
      setState(() {});
    }
  }

  Future getBanarImages() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.URL}GetBanarImages.php"),
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var images = jsonBody["images"];
      for (Map i in images) {
        imgList.add(ImagesModel(i["Id"], i["Image"]));
      }
    }
    setState(() {});
  }
}
