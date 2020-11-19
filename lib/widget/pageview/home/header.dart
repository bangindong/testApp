import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/main.user.bloc.dart';
import 'package:socialapp/blocs/post.bloc.dart';
import 'package:socialapp/static/static.dart';

class Header extends StatefulWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = Provider.of<PostBloc>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Stack(children: [
            Center(
              child: Container(
                width: 30,
                height: 30,
                child: Consumer<MainUserBloc>(
                  builder: (context, mainUser, child) {
                    print(Static.mainUser.toJson().toString());
                    return CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        Static.mainUser.avartar == null
                            ? "https://via.placeholder.com/300x300"
                            : Static.mainUser.avartar,
                      ),
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 7,
          child: Container(
            height: 35,
            child: TextField(
              controller: myController,
              cursorColor: Colors.red,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 13, decoration: TextDecoration.none),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                fillColor: Colors.grey[200],
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                filled: true,
                hintText: "What are you thinking ?",
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 10),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        postBloc.addPost(myController.value.text);
                      },
                      icon: Icon(
                        Icons.post_add,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
