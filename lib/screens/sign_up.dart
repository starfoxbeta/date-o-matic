import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/screens/dialog_flow_page.dart';
import 'package:datematic/screens/quiz/question.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/routes.dart';
import 'package:datematic/screens/login_page.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _globalKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60.0,
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
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      config.value == null
                          ? def_str_welcome
                          : config.value?.getString(str_welcome) ??
                              def_str_welcome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: headings,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    config.value == null
                        ? def_str_sign_up_txt
                        : config.value?.getString(str_sign_up_txt) ??
                            def_str_sign_up_txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8798AD),
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5.0, right: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Color(0xFF2E5BFF))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              CircleAvatar(
                                radius: 24.0,
                                child: Center(
                                  child: Container(
                                    height: 24.0,
                                    child: config.value == null
                                        ? Image.asset(
                                            energy,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: config.value
                                                ?.getString(img_energy ?? ""),
                                          ),
                                  ),
                                ),
                                backgroundColor:
                                    Color(0xFF2E5BFF).withOpacity(0.2),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25.0),
                                child: Text(
                                  config.value == null
                                      ? def_str_sign_up_txt1
                                      : config.value
                                              ?.getString(str_sign_up_txt1) ??
                                          def_str_sign_up_txt1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xFF2E384D),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  config.value == null
                                      ? def_str_sign_up_txt2
                                      : config.value
                                              ?.getString(str_sign_up_txt2) ??
                                          def_str_sign_up_txt2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF8798AD),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0)
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Color(0xFF2E5BFF),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    config.value == null
                        ? def_str_sign_up_txt3
                        : config.value?.getString(str_sign_up_txt3) ??
                            def_str_sign_up_txt3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF509A00),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 18.0),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "EMAIL ADDRESS",
                      hintStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(224, 231, 255, 0.2),
                    ),
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    style: TextStyle(fontSize: 18.0),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "PASSWORD",
                      hintStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(224, 231, 255, 0.2),
                    ),
                    onSubmitted: (value) => verifyDetails(context),
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF2E5BFF),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () => verifyDetails(context),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Color(0xFFB0BAC9),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      InkWell(
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF2E5BFF),
                          ),
                        ),
                        onTap: () => push(context: context, page: LoginPage()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyDetails(
    BuildContext context,
  ) async {
    RegExp emailExp = new RegExp(emailValidation);
    if (emailController.text == "") {
      showSnackBar(message: "Email field can not be empty", key: _globalKey);
      return;
    }
    if (passwordController.text == "") {
      showSnackBar(message: "Password field can not be empty", key: _globalKey);
      return;
    }
    if (!emailExp.hasMatch(emailController.text)) {
      showSnackBar(message: "Incorrect email address", key: _globalKey);
      return;
    }
    bool connect = await getBoolDataLocally(key: connection);
    if (connect == false) {
      showSnackBar(message: "No Internet Connection", key: _globalKey);
      return;
    }
    displayProgressDialog(context);
    String response = await ApiService.signUp(
      email: emailController.text,
      password: passwordController.text,
    );
    if (response == successful) {
      closeProgressDialog(context);
      pushReplacement(context: context, page: QuestionPage());
      print("success");
    } else if (response == error) {
      closeProgressDialog(context);
      showSnackBar(
          message: "User account could not be created", key: _globalKey);
    } else {
      closeProgressDialog(context);
      showSnackBar(message: response, key: _globalKey);
    }
  }
}
