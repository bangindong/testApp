import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:post_repository/post_repository.dart';
import 'package:socialapp/static/static.dart';
import 'package:user_repository/user_repository.dart';

class PostBloc extends ChangeNotifier {
  List<Post> posts = new List<Post>();

  getPostOfFriends() {
    PostRepository postRepository = PostRepository();
    postRepository
        .getListPosts(getListApis(Static.mainUser.friendIds))
        .then((value) {
      posts = value;
      notifyListeners();
    });
  }

  add(Post post) {
    posts.add(post);
    notifyListeners();
  }

  remove(Post post) {
    posts.remove(post);
    notifyListeners();
  }

  void addPost(String text) async {
    Post post = Post(
        userId: Static.mainUser.userId,
        countComment: 0,
        user: Static.mainUser,
        content: text);
    PostRepository postRepository = PostRepository();
    postRepository
        .addPost(updatePostApi(), json.encode(post.toJson()))
        .then((value) {
      print(value);
      if (value != null) {
        print("123");
        add(post);
      }
    });
  }

  List<String> getListApis(List<dynamic> friendIds) {
    List<String> friend = friendIds.map((id) => Static.apiRoot + "user/$id/posts").toList();
    friend.add(Static.apiRoot + "user/${Static.mainUser.userId}/posts");
    return friend;
  }

  String updatePostApi() {
    return Static.apiRoot + "user/${Static.mainUser.userId}/posts";
  }
}
