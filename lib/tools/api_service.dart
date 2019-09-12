import 'dart:convert';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ApiService {
  // This is for the google sign in
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // This user details is sent to this url after signing in
  static String _url = "https://domapp-f603e.firebaseapp.com/api/v1/signup";

  static Future login(
      {String email, String password, BuildContext context}) async {
    try {
      FirebaseUser firebaseUser = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print(firebaseUser.email);
      return successful;
    } on PlatformException catch (e) {
      print(e.message);
      return e;
    }
  }

  static Future<String> signUp({String email, String password}) async {
    try {
      final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      // this returns string after sending message to the server
      String response = await sendToApi(user);
      return response;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static Future<String> googleSignIn() async {
    // This checks if the network connection is strong enough to carry out the sign in
    bool result = await DataConnectionChecker().hasConnection;
    if (result == false) {
      return poor;
    }

    try {
      // This sign in the user through their google account
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      print(googleSignInAccount.email);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //This connects google sign in with firebase auth.
      final FirebaseUser user =
          (await auth.signInWithCredential(credential)).user;

      // this returns string after sending message to the server
      String response = await sendToApi(user);
      return response;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static Future<void> handleSignOut() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }

// this method is called in order to send user details to the API
  static Future<String> sendToApi(FirebaseUser user) async {
    try {
      String token = await firebaseMessaging.getToken();
      //String referrer = await getStringDataLocally(key: referrerId);
      if (user != null && token != null) {
        http.Response response = await http.post(
          _url,
          body: json.encode(
            {"email": user.email, "fcm_token": token, "uid": user.uid},
          ),
        );
        if (response.statusCode == 200) {
          return successful;
        } else {
          return error;
        }
      } else {
        return error;
      }
    } catch (e) {
      return e.toString();
    }
  }

// This gets each user dynamic link
  Future<void> createDynamicLink({bool short, String referrerId}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://datematic.page.link',
      link: Uri.parse('https://dynamic.link.example/$referrerId'),
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 21,
      ),
      iosParameters: IosParameters(
        bundleId: packageInfo.packageName,
        minimumVersion: '1.0.1',
        appStoreId: '',
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }
    String message = "Use my referral link to join Datematic through me";
    Share.share(
        "$message. \nFollow this link\n\n$url\n\n Open with Chrome or default browser");
  }

  static Future<String> submitQuiz(BuildContext context) async {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      try {
        await db.collection(quizCollection).document(user.uid).setData({
          quiz1: quizProvider.q1,
          quiz2: quizProvider.q2,
          quiz3: quizProvider.q3,
          quiz4: quizProvider.q4,
          quiz5: quizProvider.q5,
          quiz6: quizProvider.q6,
          "uid": user.uid,
        });
        return successful;
      } on PlatformException catch (e) {
        return error;
      }
    } else {
      return error;
    }
  }
}
