import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizOne extends StatefulWidget {
  final PageController controller;
  QuizOne({this.controller});
  @override
  _QuizOneState createState() => _QuizOneState();
}

class _QuizOneState extends State<QuizOne> with WidgetsBindingObserver {
  FocusNode zipFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode planetFocus = FocusNode();
  String _quizQuestion = "Where do you want your date?";
  TextEditingController zipController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController planetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseData().getName().then((userName) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNotification(name: userName);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    zipFocus.dispose();
    stateFocus.dispose();
    planetFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 195),
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
                        child: TextField(
                          controller: zipController,
                          focusNode: zipFocus,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "zip code",
                          ),
                          onSubmitted: (_) {
                            FocusScope.of(context).requestFocus(stateFocus);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: stateController,
                          focusNode: stateFocus,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "city state",
                          ),
                          onSubmitted: (_) {
                            FocusScope.of(context).requestFocus(planetFocus);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: planetController,
                          focusNode: planetFocus,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "planet",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: CommonText(
                      text: "enter zip code, city state, planet",
                      color: textColor,
                    ),
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
    );
  }

  _submit() {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    if (zipController.text.isEmpty ||
        stateController.text.isEmpty ||
        planetController.text.isEmpty) {
      return;
    }
    Map<String, dynamic> myResult = {
      question: _quizQuestion,
      answer: {
        zipcode: zipController.text,
        citystate: stateController.text,
        planet: planetController.text,
      }
    };
    quizProvider.setQuiz1 = myResult;
    widget.controller
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
