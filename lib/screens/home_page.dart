import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datematic/screens/menu.dart';
import 'package:datematic/tools/analytic_function.dart';
import 'package:datematic/widgets/DatematicAppBar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final String content;
  HomePage({this.content, this.analytics, this.observer});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  void initState() {
    super.initState();
    AnalyticsFunction.sendAnalytics(
        analytics: widget.analytics, screenName: "CONTENT");
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      key: _globalKey,
      appBar: DatematicAppBar(
        globalKey: _globalKey,
        context: context,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: widget.content != null
              ? HtmlWidget(
                  """${widget.content}""",
                  webView: true,
                  webViewJs: true,
                )
              : StreamBuilder(
                  stream: Firestore.instance
                      .collection("contents")
                      .document(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        ),
                      );
                    } else {
                      if (snapshot.data["content"].toString().isEmpty) {
                        return noDataFound();
                      } else {
                        var value = snapshot.data["content"];
                        return value == null
                            ? Container()
                            : HtmlWidget(
                                """$value""",
                                webView: true,
                                webViewJs: true,
                              );
                      }
                    }
                  },
                ),
        ),
      ),
      drawer: Menu(
        analytics: widget.analytics,
        observer: widget.observer,
      ),
    );
  }

  Widget noDataFound() {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Nothing Found',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text('Why don`t you create a new one?',
                    style: TextStyle(color: Colors.grey))
              ]),
        ));
  }
}
