import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class QuizSeven extends StatelessWidget {
  final PageController controller;
  QuizSeven({this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
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
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: CommonText(
            text: "We'll find dates that match you both!",
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
              margin: EdgeInsets.symmetric(horizontal: 60.0),
              onTap: () {
                controller.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              },
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        InkWell(
          child: CommonText(
            text: "Skip",
            color: Color(0xFF4A90E2),
            decoration: TextDecoration.underline,
          ),
          onTap: () {},
        )
      ],
    );
  }
}
