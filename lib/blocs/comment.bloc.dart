import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:socialapp/static/static.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:post_repository/post_repository.dart';

class CommentBloc extends ChangeNotifier {
  List<Comment> comments = new List<Comment>();

  getCommentOfPost(Post post) {
    CommentRepository commentRepository = CommentRepository();
    PostRepository postRepository = PostRepository();
    postRepository.getPost(getPostApi(post)).then((value) {
      HashMap<int, int> list = HashMap<int, int>();
      print("hellllllo " + value.comments.length.toString());
      for (String hash in value.comments) {
        var keyValue = hash.split(",").toList();
        list[int.parse(keyValue[1].trim())] = int.parse(keyValue[0].trim());
      }
      commentRepository.getListComment(getListApis(list)).then((comment) {
        comments = comment;
        notifyListeners();
      });
    });
  }

  add(Comment comment) {
    comments.add(comment);
    notifyListeners();
  }

  remove(Comment comment) {
    comments.remove(comment);
    notifyListeners();
  }

  List<String> getListApis(HashMap<int, int> commentIds) {
    List<String> list = [];
    commentIds.forEach(
        (key, value) => list.add(Static.apiRoot + "user/$value/comments/$key"));
    return list;
  }

  String getPostApi(Post post) {
    return Static.apiRoot + "user/${post.user.userId}/posts/${post.postId}";
  }

  void addComment(String text, Post post) async {
    Comment comment = Comment(
        userId: Static.mainUser.userId,
        createUser: Static.mainUser,
        content: text);
    CommentRepository commentRepository = CommentRepository();
    print(comment.toJsonAdd().toString());
    commentRepository
        .addComment(addCommentApi(), json.encode(comment.toJsonAdd()))
        .then((value) {
      print(value.toJson().toString());
      post.comments.add("${Static.mainUser.userId}, ${value.commentId}");
      PostRepository commentRepository = PostRepository();
      commentRepository
          .updatePost(updatePostApi(post), json.encode(post.toJsonAddComment()))
          .then((value) {
        print(value);
        if (value != null) {
          print("123");
          add(comment);
        }
      });
    });
  }

  String addCommentApi() {
    return Static.apiRoot + "user/${Static.mainUser.userId}/comments";
  }

  String updatePostApi(Post post) {
    return Static.apiRoot + "user/${post.userId}/posts/${post.postId}";
  }
}
