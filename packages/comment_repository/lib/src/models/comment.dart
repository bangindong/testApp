import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class Comment extends Equatable {
  final int commentId;
  final int userId;
  final String content;
  final String createAt;
  final User createUser;

  const Comment(
      {this.commentId,
      this.userId,
      this.content,
      this.createAt,
      this.createUser});

  factory Comment.fromJson(Map<String, dynamic> json) {
    print(json['friendIds']);
    return Comment(
        commentId: int.parse(json['commentId']),
        userId: int.parse(json['userId']),
        content: (json['content']),
        createAt: json['createAt'].toString(),
        createUser:
            User.fromJson(Map<String, dynamic>.from(json['createUser'])));
  }

  Map<String, dynamic> toJson() => {
        '"commentId"': '"$commentId"',
        '"userId"': '"$userId"',
        '"content"': '"$content"',
        '"createAt"': createAt,
        '"createUser"': createUser.toJson(),
      };

  Map<String, dynamic> toJsonAdd() => {
        "userId": userId,
        "content": content,
        "createAt": createAt,
        "createUser": createUser.toJson(),
      };

  @override
  List<Object> get props => [userId];

  static const empty = Comment();
}
