import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/colors.dart';
import 'package:datematic/tools/images.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstOnBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          alignment: Alignment.topCenter,
          child: Text(
            config.value == null
                ? def_str_board1
                : config.value?.getString(str_board1) ?? def_str_board1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: headings,
              fontSize: 28,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Expanded(
          child: Center(
              child: Image.asset(
            love,
          ) /* config.value == null
                ? Image.asset(
                    love,
                  )
                : CachedNetworkImage(
                    imageUrl: config.value?.getString(img_board1 ?? ""),
                  ), */
              ),
        ),
        SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
