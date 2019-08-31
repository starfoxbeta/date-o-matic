import 'package:datematic/screens/home_page.dart';
import 'package:datematic/screens/quiz/question.dart';
import 'package:datematic/screens/welcome_screen.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        ChangeNotifierProvider<MenuProvider>.value(
          value: MenuProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Datematic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Rubik",
        ),
        home: NavigationPage(),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  void initState() {
    super.initState();
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
        return user == null ? QuestionPage() : HomePage();
      },
    );
  }

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print("hello");
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print(deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }
}
