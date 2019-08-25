import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NotificationPage extends StatelessWidget {
  final String content;
  NotificationPage(this.content);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: content == null
              ? Container()
              : HtmlWidget(
                  """$content""",
                  webView: true,
                  webViewJs: true,
                ),
        ),
      ),
    );
  }
}
