import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/colors.dart';
import 'package:datematic/images.dart';
import 'package:datematic/routes.dart';
import 'package:datematic/screens/home_page.dart';
import 'package:datematic/screens/sign_up.dart';
import 'package:datematic/screens/welcome_screen.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/app_tools.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Column(
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
              height: 40.0,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                config.value == null
                    ? def_str_welcome
                    : config.value?.getString(str_welcome) ?? def_str_welcome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: headings,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    "Stress-free personalized date nights",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8798AD),
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "delivered to you fresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8798AD),
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Image.asset(
                        energy,
                        width: 16.0,
                        height: 16.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 62.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "EMAIL ADDRESS",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(224, 231, 255, 0.2),
                    ),
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                  ),
                  SizedBox(
                    height: 19.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFB0BAC9),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "PASSWORD",
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(224, 231, 255, 0.2),
                    ),
                    onSubmitted: (value) => verifyLogin(),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF2E5BFF),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () => verifyLogin(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Don't have an account?",
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
                    "Sign up",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF2E5BFF),
                    ),
                  ),
                  onTap: () {
                    push(context: context, page: SignUpPage());
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }

  verifyLogin() async {
    RegExp regExp = new RegExp(emailValidation);
    if (emailController.text == "") {
      showSnackBar(message: "Email field can not be empty", key: _globalKey);
      return;
    }
    if (passwordController.text == "") {
      showSnackBar(message: "Password field can not be empty", key: _globalKey);
      return;
    }
    if (!regExp.hasMatch(emailController.text)) {
      showSnackBar(message: "Incorrect email address", key: _globalKey);
      return;
    }
    bool connect = await getBoolDataLocally(key: connection);
    if (connect == false) {
      showSnackBar(message: "No Internet Connection", key: _globalKey);
      return;
    }
    displayProgressDialog(context);
    var response = await ApiService.login(
        email: emailController.text,
        password: passwordController.text,
        context: context);

    if (response == successful) {
      closeProgressDialog(context);
      pushAndRemove(context: context, page: HomePage());
    } else {
      closeProgressDialog(context);
      showSnackBar(message: errorFunction(response), key: _globalKey);
    }
  }
}
