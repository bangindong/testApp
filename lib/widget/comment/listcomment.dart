import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:post_repository/post_repository.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/comment.bloc.dart';
import 'package:comment_repository/comment_repository.dart';

class CommentsList extends StatelessWidget {
  CommentsList({Key key, this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final CommentBloc commentBloc =
        Provider.of<CommentBloc>(context, listen: false);
    commentBloc.getCommentOfPost(post);
    return Material(
      child: RefreshIndicator(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Consumer<CommentBloc>(
            builder: (context, bloc, child) {
              print("rebuild_comment_list");
              FocusScope.of(context).requestFocus(new FocusNode());
              return GridView.count(
                childAspectRatio: 7 / 2,
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                children: bloc == null
                    ? CircularProgressIndicator()
                    : _buildGridTileList(bloc.comments),
              );
            },
          ),
        ),
        onRefresh: () async {
          commentBloc.getCommentOfPost(post);
        },
      ),
    );
  }

  List<Container> _buildGridTileList(List<Comment> comments) => List.generate(
      comments.length,
      (i) => Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 10.0, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            comments[i].createUser == null ||
                                    comments[i].createUser.avartar == null
                                ? "https://via.placeholder.com/300x300"
                                : comments[i].createUser.avartar,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.grey[400]),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(5.0, 2.0, 2.0, 3.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              comments[i].createUser.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(5.0, 2.0, 2.0, 3.0),
                            alignment: Alignment.topLeft,
                            child: Text(comments[i].content)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
}
