import 'package:ass_login/model/images_model.dart';
import 'package:flutter/cupertino.dart';
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
  List<Categoires> cateList = [
    Categoires(1, "cat 1",
        "https://alitools.io/en/showcase/image?url=https%3A%2F%2Fae01.alicdn.com%2Fkf%2FH8b603376bcb7443aa44e9c0d1c5100a8E.jpg_480x480.jpg_.webp"),
    Categoires(2, "cat 2",
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dw7120f901/images/large/21_48476181_1.jpg?sw=1000&sh=1281&sm=cut"),
    Categoires(3, "cat 3",
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dw6ecf0971/images/large/02_48400081_2.jpg?sw=1000&sh=1281&sm=cut"),
    Categoires(4, "cat 4",
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dwd22e667d/images/large/01_48157981_2.jpg?sw=663&sh=848&sm=cut")
  ];

  List<Images> imgList = [
    Images(1,
        "https://alitools.io/en/showcase/image?url=https%3A%2F%2Fae01.alicdn.com%2Fkf%2FH8b603376bcb7443aa44e9c0d1c5100a8E.jpg_480x480.jpg_.webp"),
    Images(2,
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dw7120f901/images/large/21_48476181_1.jpg?sw=1000&sh=1281&sm=cut"),
    Images(3,
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dw6ecf0971/images/large/02_48400081_2.jpg?sw=1000&sh=1281&sm=cut"),
    Images(4,
        "https://www.accessorize.com/dw/image/v2/BDLV_PRD/on/demandware.static/-/Sites-accessorize-master-catalog/default/dwd22e667d/images/large/01_48157981_2.jpg?sw=663&sh=848&sm=cut")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.25) - 5,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return Image.network(cateList[index].image);
                }),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.75) - 240,
            child: GridView.builder(
                itemCount: cateList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
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
                        Image.network(cateList[index].image),
                        Text(cateList[index].name)
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
