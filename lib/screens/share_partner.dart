import 'package:datematic/screens/confirm_page.dart';
import 'package:datematic/screens/menu.dart';
import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/routes.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class SharePartnerPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  SharePartnerPage({this.analytics, this.observer});
  @override
  _SharePartnerPageState createState() => _SharePartnerPageState();
}

class _SharePartnerPageState extends State<SharePartnerPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "SHARE PARTNER");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: DatematicAppBar(
        globalKey: _globalKey,
        context: context,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          color: Color(0xFFF4F6FC),
          child: Card(
            elevation: 10.0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Color(0xFFFF5DB4).withOpacity(0.1),
                      child: Image.asset(
                        circle,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: Text(
                      "Share this quiz with your partner",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: headings,
                        fontSize: 34.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CommonText(
                      text: "We'll find dates that match you both!",
                      textAlign: TextAlign.center,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Button(
                        text: "Send Link",
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        onTap: () async {
                          String userId = await FirebaseData().getUserId();
                          await ApiService().createDynamicLink(
                            short: true,
                            referrerId: userId,
                            isPartner: true,
                          );
                          widget.analytics.logShare(
                              contentType: "Partner Link",
                              itemId: "",
                              method: "");
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  InkWell(
                    child: CommonText(
                      text: "SKIP",
                      color: Color(0xFF4A90E2),
                      decoration: TextDecoration.underline,
                    ),
                    onTap: () {
                      push(
                        context: context,
                        page: ConfirmationPage(
                            analytics: widget.analytics,
                            observer: widget.observer),
                        pageName: confirmationPage,
                      );
                    },
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
      drawer: Menu(
        analytics: widget.analytics,
        observer: widget.observer,
      ),
    );
  }
}
