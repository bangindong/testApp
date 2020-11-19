import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String name;
  final String avartar;
  final int age;
  final String birthday;
  final List friendIds;

  const User({
    this.userId,
    this.name,
    this.avartar,
    this.age,
    this.birthday,
    this.friendIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['friendIds']);
    return User(
        userId: int.parse(json['userId']),
        name: (json['name']),
        avartar: (json['avartar']),
        age: json['age'],
        birthday: (json['birthday']),
        friendIds: List<int>.from(json['friendIds']).toList());
  }

  Map<String, dynamic> toJson() => {
        "userId": "$userId",
        "name": "$name",
        "avatar": "$avartar",
        "age": age,
        "birthday": "$birthday",
        "friendIds": friendIds
      };

  @override
  List<Object> get props => [userId];

  static const empty = User();
}
