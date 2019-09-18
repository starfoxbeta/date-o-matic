import 'package:datematic/screens/menu.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/firebase_data.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmationPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  ConfirmationPage({this.analytics, this.observer});
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

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
                    child: Column(
                      children: <Widget>[
                        TextHeader(
                          text: "Thank you!",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextHeader(
                            text: "We received your Info.",
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextHeader(
                            text: "Your custom date night will be delivered.",
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Image.asset(
                              date,
                              height: 21.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              DateFormat("dd/MM/yyyy").format(DateTime.now()),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0018B7),
                                fontSize: 21.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              energy,
                              height: 23.0,
                            ),
                            CommonText(
                              text:
                                  "Keep an eye out for a \nnotification from us!",
                              color: textColor,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Button(
                        text: "SHARE AND GET \$20",
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        onTap: () async {
                          String userId = await FirebaseData().getUserId();
                          ApiService().createDynamicLink(
                            short: true,
                            referrerId: userId,
                            isPartner: false,
                          );
                          widget.analytics.logShare(
                              contentType: "Friend Link",
                              itemId: "",
                              method: "");
                        },
                      ),
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
      drawer: Menu(
        analytics: widget.analytics,
        observer: widget.observer,
      ),
    );
  }
}
