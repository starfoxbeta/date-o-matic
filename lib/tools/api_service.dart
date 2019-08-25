import 'dart:convert';

import 'package:datematic/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future login(
      {String email, String password, BuildContext context}) async {
    try {
      FirebaseUser firebaseUser = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return successful;
    } on PlatformException catch (e) {
      print(e.message);
      return e;
    }
  }

  static Future<String> signUp({String email, String password}) async {
    String url = "https://domapp-f603e.firebaseapp.com/api/v1/signup";
    try {
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      String token = await firebaseMessaging.getToken();
      if (user != null && token != null) {
        http.Response response = await http.post(
          url,
          body: json.encode(
            {"email": email, "fcm_token": token, "uid": user.uid},
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
    } on PlatformException catch (e) {
      return e.message;
    }
  }
}
