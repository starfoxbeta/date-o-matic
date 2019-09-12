import 'package:flutter/material.dart';

void pushReplacement({BuildContext context, Widget page}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void push({BuildContext context, Widget page}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void pushAndRemove({BuildContext context, Widget page}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false);
}
