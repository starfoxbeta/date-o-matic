import 'package:datematic/tools/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onTap;
  final EdgeInsets margin;
  final Color color;
  double width;
  Button({this.text, this.onTap, this.margin, this.width, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        width: width ?? MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Color(0xFF2E5BFF),
            borderRadius: BorderRadius.circular(4.0)),
        margin: margin ?? EdgeInsets.symmetric(horizontal: 29.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class CommonText extends StatelessWidget {
  final String text;
  final Color color;
  final TextDecoration decoration;
  TextAlign textAlign;
  CommonText({this.text, this.color, this.decoration, this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.right,
      style: TextStyle(
        color: color,
        fontSize: 18.0,
        decoration: decoration ?? TextDecoration.none,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class TextHeader extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;

  TextHeader({this.text, this.color, this.fontSize, this.textAlign});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.right,
      style: TextStyle(
        color: color ?? headings,
        fontSize: fontSize ?? 34.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
