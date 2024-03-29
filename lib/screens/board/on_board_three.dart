import 'package:datematic/screens/board/phone.dart';
import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:datematic/tools/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdOnBoardPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  ThirdOnBoardPage({this.analytics, this.observer});

  @override
  _ThirdOnBoardPageState createState() => _ThirdOnBoardPageState();
}

class _ThirdOnBoardPageState extends State<ThirdOnBoardPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "ONBOARD 3 SCREEN");
  }

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          alignment: Alignment.topCenter,
          child: Text(
            config.value == null
                ? def_str_board3
                : config.value?.getString(str_board3) ?? def_str_board3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: headings,
              fontSize: 28.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Center(
                child: Image.asset(
          romatic,
        ) /* config.value == null
              ? Image.asset(
                  romatic,
                )
              : CachedNetworkImage(
                  imageUrl: config.value?.getString(img_board3 ?? ""),
                ), */
                )),
        SizedBox(
          height: 10.0,
        ),
        GestureDetector(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFF2E5BFF),
                borderRadius: BorderRadius.circular(4.0)),
            margin: EdgeInsets.symmetric(horizontal: 29.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onTap: () => push(
              context: context,
              page: PhonePage(
                analytics: widget.analytics,
                observer: widget.observer,
              ),
              pageName: signUpPage),
        ),
        SizedBox(
          height: 50.0,
        )
      ],
    );
  }
}
