import 'dart:io';

import 'package:flutter/material.dart';
import 'package:datematic/tools/progress_dialog.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

showNotification({String name}) {
  showOverlayNotification((context) {
    return SlideDismissible(
        enable: true,
        key: Key("notify"),
        child: Material(
          color: Color.fromRGBO(89, 205, 255, 0.77),
          elevation: 16.0,
          child: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: SafeArea(
              bottom: false,
              child: ListTileTheme(
                textColor: Theme.of(context)?.accentTextTheme?.title?.color,
                iconColor: Theme.of(context)?.accentTextTheme?.title?.color,
                child: ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "WELCOME! ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        TextSpan(
                          text: name.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }, duration: Duration(seconds: 5));
}

comingSoonNotification() {
  showOverlayNotification((context) {
    return SlideDismissible(
        enable: true,
        key: Key("notify"),
        child: Material(
          color: Color.fromRGBO(89, 255, 170, 0.77),
          elevation: 16.0,
          child: Container(
            height: 150.0,
            alignment: Alignment.center,
            child: SafeArea(
              bottom: false,
              child: ListTileTheme(
                textColor: Theme.of(context)?.accentTextTheme?.title?.color,
                iconColor: Theme.of(context)?.accentTextTheme?.title?.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "COMING SOON",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Sorry, we haven't activated this feature yet!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      child: Text("Get Help",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E5BFF),
                          )),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }, duration: Duration(seconds: 3));
}

showSnackBar({String message, GlobalKey<ScaffoldState> key, Color color}) {
  key.currentState.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
      backgroundColor: color == null ? Colors.red[600] : color,
    ),
  );
}

displayProgressDialog(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
        opaque: false,
        pageBuilder: (
          BuildContext context,
          _,
          __,
        ) {
          return ProgressDialog();
        }),
  );
}

// This function helps to close the dialog
closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

String errorFunction(var e) {
  String errorType;
  if (Platform.isAndroid) {
    switch (e.message) {
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        errorType = "Incorrect Email address or Password";
        break;
      case 'The password is invalid or the user does not have a password.':
        errorType = "Incorrect Email address or Password";
        break;
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        errorType = "No Internet Connection";
        break;
      // ...
      default:
        errorType = e.message;
    }
  } else if (Platform.isIOS) {
    switch (e.code) {
      case 'Error 17011':
        errorType = "Incorrect Email address or Password";
        break;
      case 'Error 17009':
        errorType = "Incorrect Email address or Password";
        break;
      case 'Error 17020':
        errorType = "No Internet Connection";
        break;
      // ...
      default:
        errorType = e.message;
    }
  }
  return errorType;
}

writeStringDataLocally({String key, String value}) async {
  SharedPreferences local = await SharedPreferences.getInstance();
  local.setString(key, value);
}

writeBoolDataLocally({String key, bool value}) async {
  SharedPreferences local = await SharedPreferences.getInstance();
  local.setBool(key, value);
}

writeIntegerDataLocally({String key, int value}) async {
  SharedPreferences local = await SharedPreferences.getInstance();
  local.setInt(key, value);
}

getStringDataLocally({String key}) async {
  SharedPreferences local = await SharedPreferences.getInstance();
  return local.getString(key);
}

getIntegerDataLocally({String key}) async {
  SharedPreferences local = await SharedPreferences.getInstance();
  return local.getInt(key);
}

getBoolDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences local = await saveLocal;
  return local.getBool(key);
}

clearDataLocally() async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences local = await saveLocal;
  local.clear();
}
