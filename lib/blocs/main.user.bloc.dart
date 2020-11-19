import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:socialapp/static/static.dart';
import 'package:user_repository/user_repository.dart';

class MainUserBloc extends ChangeNotifier {
  UserRepository userRepository = UserRepository();
  List<User> friends;
  get() {
    userRepository.getUser(Static.mainGetUserApi).then((value) {
      Static.mainUser = value;
      print(Static.mainUser.avartar);
      userRepository
          .getListUser(getListApis(Static.mainUser.friendIds))
          .then((value) {
        friends = value;
        notifyListeners();
      });
    });
  }

  reset() {
    Static.mainUser = null;
  }

  List<String> getListApis(List<dynamic> friendIds) {
    return friendIds.map((id) => Static.apiRoot + "user/$id").toList();
  }

  void removeFriend(int userId) {
    print("1111" + Static.mainUser.friendIds.toString());
    Static.mainUser.friendIds.remove(userId);
    print("22222" + Static.mainUser.friendIds.toString());
    userRepository
        .updateUser(
            Static.apiUpdateMainUser, json.encode(Static.mainUser.toJson()))
        .then((value) {
      Static.mainUser = value;
      userRepository
          .getListUser(getListApis(Static.mainUser.friendIds))
          .then((value) {
        friends = value;
        notifyListeners();
      });
    });
  }

  void addFriend(int userId) {
    Static.mainUser.friendIds.add(userId);
    userRepository
        .updateUser(
            Static.apiUpdateMainUser, json.encode(Static.mainUser.toJson()))
        .then((value) {
      Static.mainUser = value;
      print(Static.mainUser.avartar);
      userRepository
          .getListUser(getListApis(Static.mainUser.friendIds))
          .then((value) {
        friends = value;
        notifyListeners();
      });
    });
  }
}
