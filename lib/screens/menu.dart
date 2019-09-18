import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datematic/screens/blank.dart';
import 'package:datematic/screens/confirm_page.dart';
import 'package:datematic/screens/dialog_flow_page.dart';
import 'package:datematic/screens/home_page.dart';
import 'package:datematic/screens/quiz/question.dart';
import 'package:datematic/screens/refer_friend.dart';
import 'package:datematic/screens/welcome_screen.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_data.dart' as global_data;
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  Menu({this.analytics, this.observer});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // bool _isQuizFinished = false;
  bool _isContentPageReady = false;
  @override
  void initState() {
    super.initState();
    ifQuizIsFinished();
    ifContentPageReady();
  }

  ifQuizIsFinished() async {
    var quizStatus = await getBoolDataLocally(key: "quizFinished");
    if (quizStatus == true) {
      global_data.isQuizFinished = true;
    } else {
      global_data.isQuizFinished = false;
    }
  }

  ifContentPageReady() async {
    String userId = await FirebaseData().getUserId();
    try {
      DocumentSnapshot snapshot =
          await db.collection("contents").document(userId).get();
      if (snapshot.data["content"].toString().isNotEmpty) {
        _isContentPageReady = true;
      } else {
        _isContentPageReady = false;
      }
    } catch (e) {
      _isContentPageReady = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.only(left: 16.0),
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            SizedBox(
              height: 150.0,
            ),
            Item(
              title: "Get Date Night",
              icon: menu1,
              isContentReady: _isContentPageReady,
              index: 0,
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            SizedBox(
              height: 10.0,
            ),
            Item(
              title: "Give/Get \$20",
              icon: energy,
              index: 1,
              color: Color(0xFF8C54FF),
              page: ReferFriendPage(
                analytics: widget.analytics,
                observer: widget.observer,
              ),
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            SizedBox(
              height: 10.0,
            ),
            Item(
              title: "Search",
              icon: search,
              index: 2,
              page: BlankPage(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Item(
              title: "Bookings",
              icon: date,
              index: 3,
              page: BlankPage(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Item(
              title: "Help",
              icon: chat,
              index: 4,
              page: HomePageDialogflow(
                analytics: widget.analytics,
                observer: widget.observer,
              ),
              analytics: widget.analytics,
              observer: widget.observer,
            ),
            SizedBox(
              height: 10.0,
            ),
            Item(
              title: "Logout",
              icon: logOut,
              index: 5,
              analytics: widget.analytics,
              observer: widget.observer,
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String icon;
  final page;
  final int index;
  final Color color;
  final bool isContentReady;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  Item(
      {this.title,
      this.icon,
      this.page,
      this.index,
      this.color,
      this.analytics,
      this.observer,
      this.isContentReady});

  @override
  Widget build(BuildContext context) {
    MenuProvider provider = Provider.of<MenuProvider>(context);
    var user = Provider.of<FirebaseUser>(context);
    return Container(
      decoration: BoxDecoration(
        color: provider.selectedItem == index
            ? Color(0xFFF4F6FC)
            : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: provider.selectedItem == index
                ? Color(0xFF8C54FF)
                : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
      child: ListTile(
        leading: Image.asset(
          icon,
          height: 24.0,
          width: 24.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: color ?? Color(0xFF69707F),
          ),
        ),
        onTap: () async {
          if (index == 2 || index == 3) {
            comingSoonNotification();
            return;
          }
          if (index == 0) {
            provider.setIndex = index;
            if (global_data.isQuizFinished == false) {
              pushAndRemove(
                  context: context,
                  page: QuestionPage(
                    analytics: analytics,
                    observer: observer,
                  ),
                  pageName: quizPage);
              return;
            }
            if (global_data.isQuizFinished == true && isContentReady == false) {
              pushAndRemove(
                  context: context,
                  page: ConfirmationPage(
                    analytics: analytics,
                    observer: observer,
                  ),
                  pageName: confirmationPage);
              return;
            }
            if (global_data.isQuizFinished == true && isContentReady == true) {
              pushAndRemove(
                  context: context,
                  page: HomePage(
                    analytics: analytics,
                    observer: observer,
                  ),
                  pageName: homePage);
              return;
            }
            return;
          }
          if (index == 5) {
            provider.setIndex = 0;
            await ApiService.handleSignOut();
            pushAndRemove(
                context: context,
                page: WelcomePage(
                  analytics: analytics,
                  observer: observer,
                ));
            return;
          }
          /*  if (index == 1) {
            provider.setIndex = 1;
            ApiService().createDynamicLink(short: true, referrerId: user.uid);
            Navigator.pop(context);
            return;
          } */
          provider.setIndex = index;
          pushAndRemove(context: context, page: page);
        },
      ),
    );
  }
}
