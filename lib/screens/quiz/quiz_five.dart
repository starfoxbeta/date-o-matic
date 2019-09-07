import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';

class QuizFive extends StatefulWidget {
  final PageController controller;
  QuizFive({this.controller});
  @override
  _QuizFiveState createState() => _QuizFiveState();
}

class _QuizFiveState extends State<QuizFive> {
  RangeValues values = RangeValues(0, 250);
  String currentValue = "";
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
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: TextHeader(
              text: "Which styles best describe you?",
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: CommonText(
              text: "(choose multiple)",
              color: textColor,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              height: list.length * (MediaQuery.of(context).size.width / 5.0),
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemBuilder: (context, index) {
                  return itemContainer(list[index].image, list[index].text);
                },
              )),
          SizedBox(
            height: 30.0,
          ),
          Align(
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
          )
        ],
      ),
    );
  }

  Widget itemContainer(String image, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: textColor)),
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
    );
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
