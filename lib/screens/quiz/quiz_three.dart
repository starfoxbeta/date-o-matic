import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizThree extends StatefulWidget {
  final PageController controller;
  QuizThree({this.controller});
  @override
  _QuizThreeState createState() => _QuizThreeState();
}

class _QuizThreeState extends State<QuizThree> {
  RangeValues values = RangeValues(0, 2);
  String _quizQuestion = "How extra-ordinary do you want it to be?";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topRight,
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
            height: 20.0,
          ),
          TextHeader(
            text: _quizQuestion,
          ),
          SizedBox(
            height: 50.0,
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Low-Key",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Very Extra",
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
                height: 12.0,
              ),
              RangeSlider(
                max: 5,
                min: 0,
                values: values,
                onChanged: (value) {
                  setState(() {
                    values = value;
                  });
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonText(
                      text: "Low-Key Examples:",
                      color: textColor,
                      textAlign: TextAlign.left,
                    ),
                    CommonText(
                      text: "ie. dive bar, isolated restaurant",
                      color: textColor,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10.0),
                    CommonText(
                      text: "Very Extra Examples:",
                      color: textColor,
                      textAlign: TextAlign.left,
                    ),
                    CommonText(
                      text:
                          "ie. Sky-diving, private serenade with private chef and fireworks",
                      color: textColor,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: "Next",
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                onTap: _submit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submit() {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    Map<String, dynamic> myResult = {
      question: _quizQuestion,
      answer: {
        "min": values.start.toInt(),
        "max": values.end.toInt(),
      }
    };
    quizProvider.setQuiz3 = myResult;
    widget.controller
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
