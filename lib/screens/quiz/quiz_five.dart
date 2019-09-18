import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFive extends StatefulWidget {
  final PageController controller;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  QuizFive({this.controller, this.analytics, this.observer});
  @override
  _QuizFiveState createState() => _QuizFiveState();
}

class _QuizFiveState extends State<QuizFive> {
  String _quizQuestion = "Which styles best describe you?";

  @override
  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "QUIZ 5");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topRight,
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
              child: TextHeader(
                text: _quizQuestion,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.topRight,
              child: CommonText(
                text: "(choose multiple)",
                color: textColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Consumer<StylesSelectionProvider>(
              builder: (context, styleProvider, child) {
                return Container(
                    height:
                        list.length * (MediaQuery.of(context).size.width / 4.9),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        return itemContainer(
                            list[index].image, list[index].text, styleProvider);
                      },
                    ));
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: "Next",
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                onTap: _submit,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemContainer(
      String image, String text, StylesSelectionProvider styleProvider) {
    return InkWell(
      onLongPress: () {
        styleProvider.addList = text;
      },
      onTap: () {
        if (styleProvider.getList.length >= 1) {
          styleProvider.addList = text;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          border: Border.all(
            width: styleProvider.getList.contains(text) ? 2.0 : 1.0,
            color: styleProvider.getList.contains(text)
                ? Colors.purple
                : textColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Color(0xFFFF5DB4).withOpacity(0.1),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            CommonText(
              text: text,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    StylesSelectionProvider style =
        Provider.of<StylesSelectionProvider>(context);
    Map<String, dynamic> myResult = {
      question: _quizQuestion,
      answer: style.getList
    };
    quizProvider.setQuiz5 = myResult;
    widget.controller
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

class Item {
  String image;
  String text;
  Item(this.image, this.text);
}

List<Item> list = [
  Item(one, "Foodie"),
  Item(two, "Glam"),
  Item(three, "Traveler"),
  Item(three, "Outdoorsy"),
  Item(three, "Theatre Lover"),
  Item(three, "Sporty"),
  Item(three, "Dancer"),
  Item(three, "Music Lover"),
  Item(nine, "Scholarly"),
  Item(three, "Homebody"),
  Item(three, "Techy"),
  Item(three, "Adventurer"),
  Item(three, "Artsy"),
  Item(three, "Other"),
];
