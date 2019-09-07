import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/routes.dart';
import 'package:datematic/screens/pin_creation_screen/pin_code_view.dart';
import 'package:datematic/screens/quiz/question.dart';
import 'package:datematic/screens/sign_up.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:datematic/widgets/widget_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String phoneNumber = '';
  bool valid = false;
  bool open = false;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  String _message = '';
  String _verificationId;
  bool phoneVerified = false;

  void onPhoneNumberChanged(String phoneNumber) {
    print(this.phoneNumber);
    setState(() {
      this.phoneNumber = phoneNumber;
    });
  }

  void onInputChanged(bool value) {
    print(value);
    setState(() {
      valid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          resizeToAvoidBottomPadding: true,
          key: _globalKey,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              Container(
                height: 35.0,
                child: config.value == null
                    ? Image.asset(
                        logo,
                      )
                    : CachedNetworkImage(
                        imageUrl: config.value?.getString(app_logo ?? ""),
                      ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                child: Column(
                  children: <Widget>[
                    InternationalPhoneNumberInput(
                      onInputChanged: onPhoneNumberChanged,
                      onInputValidated: onInputChanged,
                      initialCountry2LetterCode: 'US',
                      hintText: "ENTER MOBILE NUMBER",
                      shouldValidate: true,
                      shouldParse: true,
                      inputDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      child: Button(
                        text: "Verify",
                        width: 130.0,
                        margin: EdgeInsets.all(0.0),
                        onTap: () {
                          verifyPhone(phoneNumber: phoneNumber);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  child: Text("Use something else",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF2E5BFF),
                      )),
                  onPressed: () {
                    setState(() {
                      open = !open;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        if (phoneVerified)
          WillPopScope(
            onWillPop: () {
              setState(() {
                phoneVerified = false;
              });
              return;
            },
            child: Scaffold(
              key: _key,
              backgroundColor: Colors.white,
              body: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80.0,
                    ),
                    Container(
                      height: 35.0,
                      child: config.value == null
                          ? Image.asset(
                              logo,
                            )
                          : CachedNetworkImage(
                              imageUrl: config.value?.getString(app_logo ?? ""),
                            ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Enter verification code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: headings,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    PinCode(
                      codeLength: 6,
                      backgroundColor: Colors.white,
                      child: Container(),
                      onCodeFail: (code) async {
                        try {
                          final AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                            verificationId: _verificationId,
                            smsCode: code,
                          );
                          final FirebaseUser user =
                              (await auth.signInWithCredential(credential))
                                  .user;
                          final FirebaseUser currentUser =
                              await auth.currentUser();
                          if (currentUser != null) {
                            ApiService.sendToApi(user);
                            pushReplacement(
                                context: context, page: QuestionPage());
                          }
                        } on PlatformException catch (e) {
                          showSnackBar(message: e.message, key: _key);
                        }
                      },
                      onCodeSuccess: (code) async {},
                    )
                  ],
                ),
              ),
            ),
          ),
        if (open)
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomLeft,
              child: Card(
                color: Colors.black,
                margin: EdgeInsets.all(20.0),
                elevation: 5.0,
                child: Container(
                  height: 315.0,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Sign up with:",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      FlatButton(
                        child: Text("Facebook",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            )),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        child: Text("Google",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          verifyGoogleSignIn();
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        child: Text("Email",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            )),
                        onPressed: () {
                          setState(() {
                            open = false;
                          });
                          push(context: context, page: SignUpPage());
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          child: Text("Close",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF2E5BFF),
                              )),
                          onPressed: () {
                            setState(() {
                              open = !open;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  verifyGoogleSignIn() async {
    setState(() {
      open = false;
    });
    bool connect = await getBoolDataLocally(key: connection);
    if (connect == false) {
      showSnackBar(message: "No Internet Connection", key: _globalKey);
      return;
    }
    displayProgressDialog(context);
    String response = await ApiService.googleSignIn();
    if (response == successful) {
      closeProgressDialog(context);
      pushReplacement(context: context, page: QuestionPage());
    } else if (response == error) {
      closeProgressDialog(context);
      showSnackBar(
          message: "User account could not be created", key: _globalKey);
    } else if (response == poor) {
      closeProgressDialog(context);
      showSnackBar(message: "Poor Internet Connection", key: _globalKey);
    } else {
      closeProgressDialog(context);
      showSnackBar(message: response, key: _globalKey);
    }
  }

  verifyPhone({String phoneNumber}) async {
    bool connect = await getBoolDataLocally(key: connection);
    if (connect == false) {
      showSnackBar(message: "No Internet Connection", key: _globalKey);
      return;
    }
    displayProgressDialog(context);
    bool result = await DataConnectionChecker().hasConnection;
    if (result == false) {
      closeProgressDialog(context);
      showSnackBar(message: "Poor Internet Connection", key: _globalKey);
      return;
    }

    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      FirebaseUser user =
          (await auth.signInWithCredential(phoneAuthCredential)).user;
      closeProgressDialog(context);
      if (user != null) {
        ApiService.sendToApi(user);
        pushReplacement(context: context, page: QuestionPage());
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      closeProgressDialog(context);
      showSnackBar(
          message:
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
          key: _globalKey);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      closeProgressDialog(context);
      print(verificationId);
      setState(() {
        phoneVerified = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      print(verificationId);
      setState(() {
        phoneVerified = true;
      });
    };

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
