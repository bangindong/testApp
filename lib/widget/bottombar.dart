import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomBar extends StatefulWidget {
  final Function changePage;

  const MyBottomBar({Key key, this.changePage}) : super(key: key);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.blue,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.people),
                iconSize: 30,
                onPressed: () {
                  print('0');
                  widget.changePage(0);
                },
              ),
              Container(),
              IconButton(
                icon: Icon(Icons.account_circle_outlined),
                iconSize: 30,
                onPressed: () {
                  widget.changePage(2);
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          Positioned(
            top: -30.0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.home),
                  iconSize: 25,
                  onPressed: () {
                    widget.changePage(1);
                  },
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
