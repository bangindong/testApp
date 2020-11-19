import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:post_repository/post_repository.dart';
import 'package:socialapp/static/static.dart';
import 'package:user_repository/user_repository.dart';

class PostUserBloc extends ChangeNotifier {
  List<Post> posts = new List<Post>();

  getPost() {
    PostRepository postRepository = PostRepository();
    postRepository.getListPostsMain(getListApis()).then((value) {
      posts = value;
      notifyListeners();
    });
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

  add(Post post) {
    posts.add(post);
    notifyListeners();
  }

  remove(Post post) {
    posts.remove(post);
    notifyListeners();
  }

  String getListApis() {
    return Static.apiRoot + "user/${Static.mainUser.userId}/posts";
  }

  String updatePostApi() {
    return Static.apiRoot + "user/${Static.mainUser.userId}/posts";
  }
}
