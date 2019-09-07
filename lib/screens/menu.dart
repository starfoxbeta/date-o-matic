import 'package:cached_network_image/cached_network_image.dart';
import 'package:datematic/images.dart';
import 'package:datematic/routes.dart';
import 'package:datematic/screens/dialog_flow_page.dart';
import 'package:datematic/screens/welcome_screen.dart';
import 'package:datematic/tools/api_service.dart';
import 'package:datematic/tools/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            "",
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF2E384D),
                        ),
                      ),
                      Text(
                        "Jane",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF69707F),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Item(
              title: "Get Date Night",
              icon: menu1,
              index: 0,
            ),
            Item(
              title: "Give/Get \$20",
              icon: energy,
              index: 1,
              color: Color(0xFF8C54FF),
            ),
            Item(
              title: "Search",
              icon: search,
              index: 2,
            ),
            Item(
              title: "Bookings",
              icon: date,
              index: 3,
            ),
            Item(
              title: "Help",
              icon: chat,
              index: 4,
              page: HomePageDialogflow(),
            ),
            Item(
              title: "Logout",
              icon: logOut,
              index: 5,
            ),
            SizedBox(
              height: 50.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Datematic Credits: \$200",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF535353),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String icon;
  final page;
  final int index;
  final Color color;

  Item({this.title, this.icon, this.page, this.index, this.color});

  @override
  Widget build(BuildContext context) {
    MenuProvider provider = Provider.of<MenuProvider>(context);
    var user = Provider.of<FirebaseUser>(context);
    return Container(
      decoration: BoxDecoration(
        color: provider.selectedItem == index
            ? Color(0xFFF4F6FC)
            : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: provider.selectedItem == index
                ? Color(0xFF8C54FF)
                : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
      child: ListTile(
        leading: Image.asset(
          icon,
          height: 24.0,
          width: 24.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: color ?? Color(0xFF69707F),
          ),
        ),
        onTap: () async {
          if (index == 5) {
            provider.setIndex = 0;
            await ApiService.handleSignOut();
            pushAndRemove(context: context, page: WelcomePage());
            return;
          }
          if (index == 1) {
            provider.setIndex = 1;
            ApiService().createDynamicLink(short: true, referrerId: user.uid);
            Navigator.pop(context);
            return;
          }
          provider.setIndex = index;
          pushAndRemove(context: context, page: page);
        },
      ),
    );
  }
}
