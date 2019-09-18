import 'package:datematic/screens/home_page.dart';
import 'package:datematic/screens/menu.dart';
import 'package:datematic/screens/quiz/quiz_five.dart';
import 'package:datematic/screens/quiz/quiz_four.dart';
import 'package:datematic/screens/quiz/quiz_one.dart';
import 'package:datematic/screens/quiz/quiz_six.dart';
import 'package:datematic/screens/quiz/quiz_three.dart';
import 'package:datematic/screens/quiz/quiz_two.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/routes.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  QuestionPage({this.analytics, this.observer});
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final _controller = PageController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        String content = message["data"]["content"];
        pushReplacement(
            context: context,
            page: HomePage(
              content: content,
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            pageName: homePage);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        String content = message["data"]["content"];
        pushReplacement(
            context: context,
            page: HomePage(
              content: content,
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            pageName: homePage);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        String content = message["data"]["content"];
        pushReplacement(
            context: context,
            page: HomePage(
              content: content,
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            pageName: homePage);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    FirebaseData().update();
    setUserAnalytics();
  }

  Future<Null> setUserAnalytics() async {
    String userId = await FirebaseData().getUserId();
    widget.analytics.setUserId(userId);
  }

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
                            QuizOne(
                                controller: _controller,
                                analytics: widget.analytics,
                                observer: widget.observer),
                            QuizTwo(
                                controller: _controller,
                                analytics: widget.analytics,
                                observer: widget.observer),
                            QuizThree(
                                controller: _controller,
                                analytics: widget.analytics,
                                observer: widget.observer),
                            QuizFour(
                                controller: _controller,
                                analytics: widget.analytics,
                                observer: widget.observer),
                            QuizFive(
                                controller: _controller,
                                analytics: widget.analytics,
                                observer: widget.observer),
                            QuizSix(
                                analytics: widget.analytics,
                                observer: widget.observer),
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
        drawer: Menu(
          analytics: widget.analytics,
          observer: widget.observer,
        ),
      ),
    );
  }
}
