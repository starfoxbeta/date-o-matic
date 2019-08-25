import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datematic/routes.dart';
import 'package:datematic/screens/board/notification_page.dart';
import 'package:datematic/screens/dialog_flow_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String content;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        content = message["data"]["content"];
        pushReplacement(context: context, page: NotificationPage(content));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        content = message["data"]["content"];
        pushReplacement(context: context, page: NotificationPage(content));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        content = message["data"]["content"];
        pushReplacement(context: context, page: NotificationPage(content));
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.navigate_next,
              color: Colors.blue,
              size: 40.0,
            ),
            onPressed: () {
              push(context: context, page: HomePageDialogflow());
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: StreamBuilder(
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
