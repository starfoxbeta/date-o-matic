import 'package:datematic/screens/menu.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: DatematicAppBar(
        globalKey: _globalKey,
        context: context,
      ),
      body: Center(
        child: Text(
          "This is a Blank Page",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      drawer: Menu(),
    );
  }
}
