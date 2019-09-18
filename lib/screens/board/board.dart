import 'package:datematic/screens/board/on_board_one..dart';
import 'package:datematic/screens/board/on_board_three.dart';
import 'package:datematic/screens/board/on_board_two.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardPage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  BoardPage({this.analytics, this.observer});
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
                height: 35.0,
                child: Image.asset(
                  logo,
                ) /* config.value == null
                  ? Image.asset(
                      logo,
                    )
                  : CachedNetworkImage(
                      imageUrl: config.value?.getString(app_logo ?? ""),
                    ), */
                ),
            SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: PageView(
                children: <Widget>[
                  FirstOnBoardPage(
                    analytics: analytics,
                    observer: observer,
                  ),
                  SecondOnBoardPage(
                    analytics: analytics,
                    observer: observer,
                  ),
                  ThirdOnBoardPage(
                    analytics: analytics,
                    observer: observer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
