import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsFunction {
  static Future<Null> sendAnalytics(
      {FirebaseAnalytics analytics, String screenName}) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<Null> signUpAnalytics(
      {FirebaseAnalytics analytics, String signupMethod}) async {
    await analytics.logSignUp(signUpMethod: signupMethod);
  }

  static Future<Null> loginAnalytics(
      {FirebaseAnalytics analytics, String loginMethod}) async {
    await analytics.logLogin(loginMethod: loginMethod);
  }
}
