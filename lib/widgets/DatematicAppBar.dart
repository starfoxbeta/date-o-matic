import 'package:datematic/tools/app_provider.dart';
import 'package:datematic/tools/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatematicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final GlobalKey<ScaffoldState> globalKey;
  DatematicAppBar({this.globalKey, this.context});
  @override
  Widget build(BuildContext context) {
    var config = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset(
                    menu,
                    height: 20.0,
                    width: 20.0,
                    fit: BoxFit.contain,
                  ),
                ),
                onTap: () {
                  globalKey.currentState.openDrawer();
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  height: 35.0,
                  child: Image.asset(
                    logo,
                  ) /* config.value == null
                            ? Image.asset(
                                logo,
                              )
                            : CachedNetworkImage(
                                imageUrl: config.value?.getString(app_logo ?? ""),
                              ), */
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(context).size.width, 80);
}

Widget datematicAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 125.0, right: 132.0, top: 20.0),
      child: Image.asset(
        logo,
        width: MediaQuery.of(context).size.width,
      ),
    ),
  );
}
