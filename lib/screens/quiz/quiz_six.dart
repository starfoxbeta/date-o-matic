import 'package:datematic/screens/share_partner.dart';
import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/routes.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class QuizSix extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  QuizSix({this.analytics, this.observer});
  @override
  _QuizSixState createState() => _QuizSixState();
}

class _QuizSixState extends State<QuizSix> {
  RangeValues values = RangeValues(0, 250);
  String currentValue = "";
  String _quizQuestion = "Any special requests?";

  bool petFriendly = true;
  bool nonSmoking = true;
  bool makeOutSpot = true;
  bool touristOkay = false;

  String pet = "Pet Friendly";
  String smoke = "Non-Smoking";
  String make = "Make-out-Spots";
  String tourist = "Tourist Okay";
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "QUIZ 6");
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
            TextHeader(
              text: _quizQuestion,
              fontSize: 30.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        pet,
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
                        smoke,
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
                        make,
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
                        tourist,
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green.withOpacity(0.1),
              ),
              child: TextField(
                controller: otherController,
                maxLines: 10,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration.collapsed(
                    hintText: "OTHER", hintStyle: TextStyle(fontSize: 16.0)),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Consumer<LoadProvider>(
              builder: (context, isLoading, child) {
                return isLoading.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Button(
                        text: "Done",
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        onTap: () async {
                          _submit();
                          isLoading.setLoadingStatus = true;
                          String result = await ApiService.submitQuiz(context);
                          if (result == successful) {
                            isLoading.setLoadingStatus = false;
                            isQuizFinished = true;
                            writeBoolDataLocally(
                                key: "quizFinished", value: true);

                            pushAndRemove(
                                context: context,
                                page: SharePartnerPage(
                                    analytics: widget.analytics,
                                    observer: widget.observer),
                                pageName: sharePartnerPage);
                            return;
                          }
                          isLoading.setLoadingStatus = false;
                          showSnackBar(
                              message:
                                  "An error encountered when saving your data");
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide').whenComplete(() {
      QuizProvider quizProvider = Provider.of<QuizProvider>(context);
      Map<String, dynamic> myResult = {
        question: _quizQuestion,
        answer: {
          pet: petFriendly,
          smoke: nonSmoking,
          make: makeOutSpot,
          tourist: touristOkay,
          "Other": otherController.text,
        },
      };
      quizProvider.setQuiz6 = myResult;
    });
  }
}
