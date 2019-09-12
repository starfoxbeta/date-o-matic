import 'package:datematic/screens/menu.dart';
import 'package:datematic/screens/quiz/quiz_five.dart';
import 'package:datematic/screens/quiz/quiz_four.dart';
import 'package:datematic/screens/quiz/quiz_one.dart';
import 'package:datematic/screens/quiz/quiz_six.dart';
import 'package:datematic/screens/quiz/quiz_three.dart';
import 'package:datematic/screens/quiz/quiz_two.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatelessWidget {
  final _controller = PageController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () {
        _controller.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        return;
      },
      child: Scaffold(
        key: _globalKey,
        appBar: DatematicAppBar(
          globalKey: _globalKey,
          context: context,
        ),
        body: Container(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              color: Color(0xFFF4F6FC),
              child: Card(
                elevation: 10.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      Expanded(
                        child: PageView(
                          controller: _controller,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            QuizOne(controller: _controller),
                            QuizTwo(controller: _controller),
                            QuizThree(controller: _controller),
                            QuizFour(controller: _controller),
                            QuizFive(controller: _controller),
                            QuizSix(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: Menu(),
      ),
    );
  }
}
