import 'package:datematic/screens/board/board.dart';
import 'package:datematic/screens/login_page.dart';
import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:datematic/tools/routes.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  WelcomePage({this.analytics, this.observer});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "WELCOME SCREEN");
  }

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 35.0,
              child: Image.asset(
                logo,
              ), /*config.value == null
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                config.value == null
                    ? def_str_welcome
                    : config.value?.getString(str_welcome) ?? def_str_welcome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: headings,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Stress-free personalized date nights",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF8798AD),
                        fontSize: 16.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "delivered to you fresh",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF8798AD),
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Image.asset(
                          energy,
                          width: 18.0,
                          height: 18.0,
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 30.0,
            ),
            Button(
              onTap: () => push(
                  context: context,
                  page: BoardPage(
                    analytics: widget.analytics,
                    observer: widget.observer,
                  ),
                  pageName: onBoardPage),
              text: config.value == null
                  ? def_btn_welcome
                  : config.value?.getString(btn_welcome) ?? def_btn_welcome,
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Center(
                  child: Image.asset(
                image,
              ) /* config.value == null
                    ? Image.asset(
                        image,
                      )
                    : CachedNetworkImage(
                        imageUrl: config.value?.getString(img_welcome ?? ""),
                      ), */
                  ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(color: Color(0xFFB0BAC9), fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF2E5BFF),
                    ),
                  ),
                  onTap: () {
                    push(
                        context: context,
                        page: LoginPage(
                          analytics: widget.analytics,
                          observer: widget.observer,
                        ),
                        pageName: loginPage);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
