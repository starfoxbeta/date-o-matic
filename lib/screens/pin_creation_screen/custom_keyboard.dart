import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final Function onBackPressed, onPressedKey;
  final TextStyle textStyle;
  CustomKeyboard({
    this.onBackPressed,
    this.onPressedKey,
    this.textStyle,
  });

  CustomKeyboardState createState() => CustomKeyboardState();
}

class CustomKeyboardState extends State<CustomKeyboard> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyBoard(
                  onTap: () => widget.onPressedKey("1"),
                  value: "1",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("2"),
                  value: "2",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("3"),
                  value: "3",
                  style: widget.textStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyBoard(
                  onTap: () => widget.onPressedKey("4"),
                  value: "4",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("5"),
                  value: "5",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("6"),
                  value: "6",
                  style: widget.textStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                KeyBoard(
                  onTap: () => widget.onPressedKey("7"),
                  value: "7",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("8"),
                  value: "8",
                  style: widget.textStyle,
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("9"),
                  value: "9",
                  style: widget.textStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 60,
                    width: 115,
                    alignment: Alignment.center,
                    child: Text(
                      "",
                    ),
                  ),
                ),
                KeyBoard(
                  onTap: () => widget.onPressedKey("0"),
                  value: "0",
                  style: widget.textStyle,
                ),
                GestureDetector(
                  onTap: () => widget.onBackPressed(),
                  child: Container(
                      height: 60,
                      width: 115,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Color(0xFFc9ffdb))),
                      child: Icon(
                        Icons.backspace,
                        color: Colors.white,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class KeyBoard extends StatelessWidget {
  final String value;
  final Function onTap;
  final TextStyle style;

  KeyBoard({this.onTap, this.style, this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 115,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Color(0xFFc9ffdb))),
        child: Text(
          value,
          style: style,
        ),
      ),
    );
  }
}
