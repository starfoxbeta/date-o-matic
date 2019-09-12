import 'package:datematic/screens/confirm_page.dart';
import 'package:datematic/screens/menu.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/routes.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class SharePartnerPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Color(0xFFFF5DB4).withOpacity(0.1),
                      child: Image.asset(
                        circle,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: Text(
                      "Share this quiz with your partner",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: headings,
                        fontSize: 34.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CommonText(
                      text: "We'll find dates that match you both!",
                      textAlign: TextAlign.center,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Button(
                        text: "Send Link",
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        onTap: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  InkWell(
                    child: CommonText(
                      text: "SKIP",
                      color: Color(0xFF4A90E2),
                      decoration: TextDecoration.underline,
                    ),
                    onTap: () {
                      push(
                        context: context,
                        page: ConfirmationPage(),
                      );
                    },
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
      drawer: Menu(),
    );
  }
}
