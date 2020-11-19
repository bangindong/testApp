import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_repository/post_repository.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/blocs/main.user.bloc.dart';
import 'package:socialapp/blocs/post.bloc.dart';
import 'package:socialapp/page/comment.dart';
import 'package:socialapp/static/static.dart';
import 'dart:math' as math;
import 'package:user_repository/user_repository.dart';

class PostsListHome extends StatefulWidget {
  @override
  _PostsListHomeState createState() => _PostsListHomeState();
}

class _PostsListHomeState extends State<PostsListHome>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = Provider.of<PostBloc>(context, listen: false);
    return Consumer<MainUserBloc>(
      builder: (context, post, child) {
        if (Static.mainUser.friendIds != null) {
          postBloc.getPostOfFriends();
        }
        return Expanded(
          child: Material(
            child: RefreshIndicator(
              child: Container(
                child: Consumer<PostBloc>(
                  builder: (context, post, child) {
                    print("rebuild_list_home");
                    return GridView.count(
                      childAspectRatio: 7 / 5,
                      crossAxisCount: 1,
                      padding: EdgeInsets.all(5.0),
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      children: _buildGridTileList(post.posts),
                    );
                  },
                ),
              ),
              onRefresh: () async {
                if (Static.mainUser.friendIds != null) {
                  postBloc.getPostOfFriends();
                }
              },
            ),
          ),
        );
      },
    );
  }

  List<Container> _buildGridTileList(List<Post> posts) => List.generate(
      posts.length,
      (i) => Container(
          child: Card(
              margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                  posts[i].user.avartar == null
                                      ? "https://via.placeholder.com/300x300"
                                      : posts[i].user.avartar,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Expanded(
                                flex: 6,
                                child: Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(posts[i].user.name))),
                          ],
                        )),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(posts[i].content)),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                            posts[i].countComment.toString() + " bình luận "),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Divider(
                          color: Colors.grey[800],
                          thickness: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton.icon(
                          elevation: 0,
                          color: Colors.transparent,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CommentPage(post: posts[i])));
                          },
                          label: Text("Bình luận"),
                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(
                              Icons.mode_comment_outlined,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))));

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
