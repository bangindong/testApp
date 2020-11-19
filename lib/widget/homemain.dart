import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/widget/pageview/mainuser/headermain.dart';
import 'file:///F:/testApp/socialapp/lib/widget/pageview/mainuser/listpostuser.dart';
import 'file:///F:/testApp/socialapp/lib/widget/pageview/user/listuser.dart';

import 'pageview/home/header.dart';
import 'pageview/home/listposthome.dart';

class Main extends StatefulWidget {
  Main({
    Key key,
  }) : super(key: key);

  var controller = PageController(
    initialPage: 1,
  );

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  void changePage(index) {
    setState(() {
      widget.controller.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: widget.controller,
        scrollDirection: Axis.horizontal,
        children: [
          UsersList(),
          Container(
            child: Column(
              children: [
                Header(),
                PostsListHome(),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                HeaderMain(),
                PostsListUser(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
