import 'package:datematic/screens/menu.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class ReferFriendPage extends StatefulWidget {
  @override
  _ReferFriendPageState createState() => _ReferFriendPageState();
}

class _ReferFriendPageState extends State<ReferFriendPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool isSharedWithPartner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: DatematicAppBar(
        globalKey: _globalKey,
        context: context,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          color: Color(0xFFF4F6FC),
          child: Card(
            elevation: 10.0,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextHeader(
                      text: "Refer-a-Friend",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextHeader(
                      text:
                          "Give \$10 to a friend who could use this, and get \$10!",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Button(
                      text: "SHARE",
                      color: Colors.purple,
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Wrap(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            accentColor: Color(0xFFAE09D7),
                          ),
                          child: CheckboxListTile(
                            value: isSharedWithPartner,
                            onChanged: (value) {
                              setState(() {
                                isSharedWithPartner = value;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Container(
                              child: TextHeader(
                                fontSize: 22.0,
                                color: Color(0xFF8020CC),
                                text:
                                    "I'm sharing this with my partner, link them to my account",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Menu(),
    );
  }
}
