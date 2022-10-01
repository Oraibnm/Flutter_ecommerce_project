import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
          ),
          Image.asset(
            "158579252741c39c18cd12b2dc759b6018aadfd41a.webp",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
