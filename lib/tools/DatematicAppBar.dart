import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/images.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/remote_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatematicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final GlobalKey<ScaffoldState> globalKey;
  DatematicAppBar({this.globalKey, this.context});
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.only(top: 38.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Image.asset(
                menu,
                height: 14,
                width: 18.0,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              globalKey.currentState.openDrawer();
            },
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 35.0,
              child: config.value == null
                  ? Image.asset(
                      logo,
                    )
                  : CachedNetworkImage(
                      imageUrl: config.value?.getString(app_logo ?? ""),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(context).size.width, 70);
}
