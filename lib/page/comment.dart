import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_repository/src/models/post.dart';
import 'package:socialapp/widget/comment/bottom.dart';
import 'file:///F:/testApp/socialapp/lib/widget/comment/listcomment.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.title, this.post}) : super(key: key);

  final Post post;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  CommentsList _child;

  @override
  void initState() {
    _child = CommentsList(
      post: widget.post,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: <Widget>[
            Expanded(child: _child),
            BottomOfComment(post: widget.post),
          ],
        ),
      ),
    );
  }
}
