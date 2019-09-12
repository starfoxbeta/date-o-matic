import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizTwo extends StatefulWidget {
  final PageController controller;
  QuizTwo({this.controller});
  @override
  _QuizTwoState createState() => _QuizTwoState();
}

class _QuizTwoState extends State<QuizTwo> {
  RangeValues values = RangeValues(78, 250);
  String _quizQuestion = "How much do you want to spend?";

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
              backgroundColor: Color(0xFF33AC2E).withOpacity(0.1),
              child: Image.asset(
                check,
                height: 25.0,
                width: 25.0,
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
            height: 80.0,
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    amountDisplay(values.start.toInt().toString()),
                    amountDisplay(
                      values.end.toInt() == 500
                          ? "500+"
                          : values.end.toInt().toString(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              RangeSlider(
                max: 500,
                min: 0,
                values: values,
                onChanged: (value) {
                  setState(() {
                    values = value;
                  });
                },
              ),
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

  Widget amountDisplay(String value) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "\$",
          style: TextStyle(
            color: textColor,
            fontSize: 28.0,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
          ),
        ),
      ]),
    );
  }

  _submit() {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    int end = values.end.toInt() == 500 ? "500+" : values.end.toInt();
    Map<String, dynamic> myResult = {
      question: _quizQuestion,
      answer: {
        "min": values.start.toInt(),
        "max": values.end.toInt(),
      }
    };
    quizProvider.setQuiz2 = myResult;
    widget.controller
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
