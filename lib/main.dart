import 'package:datematic/screens/confirm_page.dart';
import 'package:datematic/screens/home_page.dart';
import 'package:datematic/screens/quiz/question.dart';
import 'package:datematic/screens/welcome_screen.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Config>.value(
          value: Stream.fromIterable([Config()]),
        ),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
        StreamProvider<ConnectivityStatus>.controller(
          builder: (context) =>
              ConnectivityService().connectionStatusController,
        ),
        ChangeNotifierProvider<AppProvider>.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider<StylesSelectionProvider>.value(
          value: StylesSelectionProvider(),
        ),
        Provider<QuizProvider>.value(
          value: QuizProvider(),
        ),
        ChangeNotifierProvider<MenuProvider>.value(
          value: MenuProvider(),
        ),
        ChangeNotifierProvider<LoadProvider>.value(
          value: LoadProvider(),
        ),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Datematic',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Rubik",
          ),
          navigatorObservers: <NavigatorObserver>[observer],
          home: NavigationPage(analytics: analytics, observer: observer),
        ),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  NavigationPage({this.analytics, this.observer});
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
    widget.analytics.setAnalyticsCollectionEnabled(true);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _retrieveDynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var value = Provider.of<Config>(context);
    var config = Provider.of<AppProvider>(context);
    return StreamBuilder(
      stream: value?.setupRemoteConfig()?.asStream(),
      builder: (context, snapshot) {
        config.setRemote = snapshot?.data;
        return user == null
            ? WelcomePage(
                analytics: widget.analytics, observer: widget.observer)
            : QuestionPage(
                analytics: widget.analytics, observer: widget.observer);
      },
    );
  }

// This function is called to retrieve dynamic link
  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      String path = deepLink.path.toString().substring(1);
      if (path.contains(partner)) {
        writeBoolDataLocally(key: partner, value: true);
        path = deepLink.path.toString().substring(9);
      } else {
        path = deepLink.path.toString().substring(1);
      }
      writeStringDataLocally(key: referrerId, value: path);
    }
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        if (deepLink != null) {
          String path = deepLink.path.toString().substring(1);
          if (path.contains(partner)) {
            writeBoolDataLocally(key: partner, value: true);
            path = deepLink.path.toString().substring(9);
          } else {
            path = deepLink.path.toString().substring(1);
          }
          writeStringDataLocally(key: referrerId, value: path);
        }
      },
      onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      },
    );
  }

  Future<Widget> getNextWidget(FirebaseUser user) async {
    bool isQuizFinished = false;
    bool isContentReady = false;
    await db
        .collection(quizCollection)
        .where("uid", isEqualTo: user.uid)
        .getDocuments()
        .then((snapshot) {
      if (snapshot.documents.length > 0) {
        isQuizFinished = true;
      } else {
        isQuizFinished = false;
      }
    }).catchError((e) {
      isQuizFinished = false;
    });

    await db.collection("contents").document(user.uid).get().then((snapshot) {
      if (snapshot.data["content"].toString().isNotEmpty) {
        isContentReady = true;
      } else {
        isContentReady = false;
      }
    }).catchError((e) {
      isContentReady = false;
    });
    if (isQuizFinished == false) {
      return QuestionPage();
    }
    if (isQuizFinished == true && isContentReady == false) {
      return ConfirmationPage();
    }
    if (isQuizFinished == true && isContentReady == true) {
      return HomePage();
    }
    return QuestionPage();
  }
}
