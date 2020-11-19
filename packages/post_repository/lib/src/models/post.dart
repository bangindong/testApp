import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class Post extends Equatable {
  final int postId;
  final int userId;
  final String createdAt;
  final String content;
  final int countComment;
  final User user;
  final List<String> comments;

  const Post(
      {this.postId,
      this.userId,
      this.createdAt,
      this.content,
      this.countComment,
      this.user,
      this.comments});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        postId: int.parse(json['postId']),
        userId: int.parse(json['userId']),
        content: (json['content']),
        countComment: json['countComment'] == null ? 0 : json['countComment'],
        user: User.fromJson(Map<String, dynamic>.from(json["user"])),
        comments: json['comments'] == null
            ? []
            : List<String>.from(json['comments']).toList());
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userId": userId,
        "content": content,
        "countComment": countComment,
        "user": user.toJson(),
        "comments": comments
      };

  Map<String, dynamic> toJsonAddComment() => {
        "postId": postId,
        "userId": userId,
        "content": content,
        "countComment": comments == null ? 0 : comments.length,
        "user": user.toJson(),
        "comments": comments
      };

  @override
  List<Object> get props => [userId];

  static const empty = Post();
}
