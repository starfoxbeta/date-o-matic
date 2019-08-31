import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFour extends StatefulWidget {
  final PageController controller;
  QuizFour({this.controller});
  @override
  _QuizFourState createState() => _QuizFourState();
}

class _QuizFourState extends State<QuizFour> {
  RangeValues values = RangeValues(0, 250);
  String currentValue = "";
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: 40.0),
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Color(0xFF33AC2E).withOpacity(0.2),
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
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextHeader(
            text: "What mood do you want?",
          ),
        ),
        SizedBox(
          height: 80.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Low Energy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "High Energy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              RangeSlider(
                max: 500,
                values: values,
                onChanged: (value) {
                  setState(() {
                    values = value;
                    currentValue =
                        "${value.start.toInt().toString()} - ${value.end.toInt().toString()}";
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: CommonText(
                  text: "i.e. concerts, skydiving, hiking, etc.",
                  color: textColor,
                ),
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
