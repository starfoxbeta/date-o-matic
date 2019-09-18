import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class QuizOne extends StatefulWidget {
  final PageController controller;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  QuizOne({this.controller, this.analytics, this.observer});
  @override
  _QuizOneState createState() => _QuizOneState();
}

class _QuizOneState extends State<QuizOne> with WidgetsBindingObserver {
  String _quizQuestion = "Where do you want your date?";
  TextEditingController posController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "QUIZ 1");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider =
        Provider.of<QuizProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseData().getName().then((userName) {
        if (quizProvider.isWelcome) {
          showNotification(name: userName);
          quizProvider.setWelcome = false;
        }
      });
    });

    return Scaffold(resizeToAvoidBottomPadding: false, body: _body());
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 250),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.topRight,
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
                        text: _quizQuestion,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your position';
                              }
                              return null;
                            },
                            controller: posController,
                            decoration: InputDecoration(
                                hintText: "enter zip code, city state, planet",
                                hintStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ],
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    SystemChannels.textInput.invokeMethod('TextInput.hide').whenComplete(() {
      QuizProvider quizProvider = Provider.of<QuizProvider>(context);
      if (!_formKey.currentState.validate()) {
        return;
      }
      Map<String, dynamic> myResult = {
        question: _quizQuestion,
        answer: {
          zipcode: posController.text,
        }
      };
      quizProvider.setQuiz1 = myResult;
      widget.controller.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }
}
