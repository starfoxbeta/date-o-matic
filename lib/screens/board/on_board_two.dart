import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondOnBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            config.value == null
                ? def_str_board2
                : config.value?.getString(str_board2) ?? def_str_board2,
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
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            config.value == null
                ? def_str_board2_txt1
                : config.value?.getString(str_board2_txt1) ??
                    def_str_board2_txt1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8798AD),
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 62.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              getMe("Memorable experiences"),
              getMe("Personalized to both of you"),
              getMe("Pre-planned, just show up"),
              getMe("Attention to detail")
            ],
          ),
        ),
        Expanded(
          child: Center(
              child: Image.asset(
            book,
          ) /* config.value == null
                ? Image.asset(
                    book,
                  )
                : CachedNetworkImage(
                    imageUrl: config.value?.getString(img_board2 ?? ""),
                  ), */
              ),
        ),
        SizedBox(
          height: 50.0,
        ),
      ],
    );
  }

  Widget getMe(String text) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            energy,
            height: 16.0,
            width: 16.0,
          ),
          SizedBox(
            width: 7.0,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF0018B7),
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
