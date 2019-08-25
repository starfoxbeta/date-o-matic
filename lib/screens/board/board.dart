import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/images.dart';
import 'package:datematic/screens/board/on_board_one..dart';
import 'package:datematic/screens/board/on_board_three.dart';
import 'package:datematic/screens/board/on_board_two.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Scaffold(
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
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: PageView(
              children: <Widget>[
                FirstOnBoardPage(),
                SecondOnBoardPage(),
                ThirdOnBoardPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
