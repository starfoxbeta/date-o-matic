import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/images.dart';
import 'package:datematic/screens/menu.dart';
import 'package:datematic/screens/quiz/quiz_eight.dart';
import 'package:datematic/screens/quiz/quiz_five.dart';
import 'package:datematic/screens/quiz/quiz_four.dart';
import 'package:datematic/screens/quiz/quiz_one.dart';
import 'package:datematic/screens/quiz/quiz_seven.dart';
import 'package:datematic/screens/quiz/quiz_six.dart';
import 'package:datematic/screens/quiz/quiz_three.dart';
import 'package:datematic/screens/quiz/quiz_two.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatelessWidget {
  PageController _controller = PageController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _globalKey,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 70),
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          padding: EdgeInsets.only(top: 38.0),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Image.asset(
                    menu,
                    height: 14,
                    width: 18.0,
                    fit: BoxFit.contain,
                  ),
                ),
                onTap: () {
                  _globalKey.currentState.openDrawer();
                },
              ),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    child: config.value == null
                        ? Image.asset(
                            logo,
                          )
                        : CachedNetworkImage(
                            imageUrl: config.value?.getString(app_logo ?? ""),
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                      QuizSix(controller: _controller),
                      QuizSeven(controller: _controller),
                      QuizEight(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Menu(),
    );
  }
}
