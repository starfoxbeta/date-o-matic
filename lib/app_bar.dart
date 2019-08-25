import 'package:datematic/images.dart';
import 'package:flutter/material.dart';

Widget datematicAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 125.0, right: 132.0, top: 20.0),
      child: Image.asset(
        logo,
        width: MediaQuery.of(context).size.width,
      ),
    ),
  );
}
