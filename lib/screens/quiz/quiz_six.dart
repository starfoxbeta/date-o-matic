import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizSix extends StatefulWidget {
  final PageController controller;
  QuizSix({this.controller});
  @override
  _QuizSixState createState() => _QuizSixState();
}

class _QuizSixState extends State<QuizSix> {
  RangeValues values = RangeValues(0, 250);
  String currentValue = "";

  bool petFriendly = true;
  bool nonSmoking = true;
  bool makeOutSpot = true;
  bool touristOkay = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: TextHeader(
              text: "Any special requests?",
              fontSize: 30.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Pet Friendly",
                      style: TextStyle(
                        color: headings,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CupertinoSwitch(
                      value: petFriendly,
                      onChanged: (val) {
                        setState(() {
                          petFriendly = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Non-Smoking",
                      style: TextStyle(
                        color: headings,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CupertinoSwitch(
                      value: nonSmoking,
                      onChanged: (val) {
                        setState(() {
                          nonSmoking = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Make-out-Spots",
                      style: TextStyle(
                        color: headings,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CupertinoSwitch(
                      value: makeOutSpot,
                      onChanged: (val) {
                        setState(() {
                          makeOutSpot = val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Tourist Okay",
                      style: TextStyle(
                        color: headings,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CupertinoSwitch(
                      value: touristOkay,
                      onChanged: (val) {
                        setState(() {
                          touristOkay = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: TextField(
              maxLines: 10,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration.collapsed(
                  hintText: "OTHER", hintStyle: TextStyle(fontSize: 16.0)),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Button(
            text: "Done",
            margin: EdgeInsets.symmetric(horizontal: 60.0),
            onTap: () {
              widget.controller.nextPage(
                  duration: Duration(milliseconds: 400), curve: Curves.easeIn);
            },
          ),
        ],
      ),
    );
  }
}
