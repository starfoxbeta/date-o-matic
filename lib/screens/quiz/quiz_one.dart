import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class QuizOne extends StatefulWidget {
  final PageController controller;
  QuizOne({this.controller});
  @override
  _QuizOneState createState() => _QuizOneState();
}

class _QuizOneState extends State<QuizOne> {
  RangeValues values = RangeValues(0, 250);
  String currentValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Color(0xFF00C1D4).withOpacity(0.2),
                  child: Image.asset(
                    location,
                    height: 25.0,
                    width: 25.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextHeader(
                  text: "Where do you want your date?",
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                alignment: Alignment.topRight,
                child: CommonText(
                  text: "enter zip code, city state, planet",
                  color: textColor,
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CommonText(
                    text: "or",
                    color: textColor,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    child: CommonText(
                      text: "enable location services",
                      color: Color(0xFF4A90E2),
                      decoration: TextDecoration.underline,
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Button(
              text: "Next",
              margin: EdgeInsets.symmetric(horizontal: 60.0),
              onTap: () {
                widget.controller.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              },
            ),
          ),
        ),
      ],
    );
  }
}
