import 'package:flutter/material.dart';

void pushReplacement({BuildContext context, Widget page, String pageName}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: pageName),
    ),
  );
}

void push({BuildContext context, Widget page, String pageName}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: pageName),
    ),
  );
}

void pushAndRemove({BuildContext context, Widget page, String pageName}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(
          name: pageName,
        ),
      ),
      (Route<dynamic> route) => false);
}
