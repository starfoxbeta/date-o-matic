import 'package:flutter/material.dart';
import './custom_keyboard.dart';
import './code_view.dart';

class PinCode extends StatefulWidget {
  final Widget child;
  final String error, correctPin;
  final Function onCodeSuccess, onCodeFail;
  final int codeLength;
  final TextStyle keyTextStyle, codeTextStyle, errorTextStyle;
  final bool obscurePin;
  final Color backgroundColor;

  PinCode({
    this.child,
    this.correctPin = "****", // Default Value, use onCodeFail as onEnteredPin
    this.error = '',
    this.codeLength = 6,
    this.obscurePin = false,
    this.onCodeSuccess,
    this.onCodeFail,
    this.errorTextStyle = const TextStyle(color: Colors.red, fontSize: 15),
    this.keyTextStyle = const TextStyle(color: Colors.white, fontSize: 25.0),
    this.codeTextStyle = const TextStyle(
        color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
    this.backgroundColor,
  });

  PinCodeState createState() => PinCodeState();
}

class PinCodeState extends State<PinCode> {
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Theme.of(context).primaryColor,
      child: Column(children: <Widget>[
        Column(
          children: <Widget>[
            widget.child,
            CodeView(
              codeTextStyle: widget.codeTextStyle,
              code: smsCode,
              obscurePin: widget.obscurePin,
              length: widget.codeLength,
            ),
            SizedBox(height: 30.0),
          ],
        ),
        SizedBox(
          height: 50.0,
        ),
        CustomKeyboard(
          textStyle: widget.keyTextStyle,
          onPressedKey: (key) {
            if (smsCode.length < widget.codeLength) {
              setState(() {
                smsCode = smsCode + key;
              });
            }
            if (smsCode.length == widget.codeLength) {
              if (smsCode == widget.correctPin) {
                widget.onCodeSuccess(smsCode);
              } else {
                widget.onCodeFail(smsCode);
                smsCode = "";
              }
            }
          },
          onBackPressed: () {
            int codeLength = smsCode.length;
            if (codeLength > 0)
              setState(() {
                smsCode = smsCode.substring(0, codeLength - 1);
              });
          },
        )
      ]),
    );
  }
}
