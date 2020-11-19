import 'package:socialapp/static/static.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {
  List<User> users = new List<User>();
  UserRepository userRepository = UserRepository();
  get() {
    userRepository.getAllUser(Static.apiGetAllUser).then((value) {
      users = value;
      notifyListeners();
    });
  }

  add(User user) {
    users.add(user);
    notifyListeners();
  }

  remove(User user) {
    users.remove(user);
    notifyListeners();
  }

  void removeFriend(int userId) {}

  void addFriend(int userId) {}
}
