import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class QuizEight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          TextHeader(
            text: "Thank you!",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextHeader(
              text: "We received your Info.", textAlign: TextAlign.center),
          SizedBox(
            height: 20.0,
          ),
          TextHeader(
              text: "Your custom date night will be delivered.",
              textAlign: TextAlign.center),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                date,
                height: 21.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "10/1/2019",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0018B7),
                  fontSize: 21.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                energy,
                height: 23.0,
              ),
              CommonText(
                text: "Keep an eye out for a \nnotification from us!",
                color: textColor,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: "SHARE AND GET \$20",
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
