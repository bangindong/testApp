import 'dart:async';
import 'dart:convert';
import 'models/models.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  User _user;

  Future<User> getUser(String api) async {
    final response = await http.get(api);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      _user =
          User.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
      print(_user.name);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu");
    }
    return _user;
  }

  Future<List<User>> getAllUser(String api) async {
    final response = await http.get(api);
    List<User> users = List<User>();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var list = (jsonDecode(response.body) as List)
          .map((data) => User.fromJson(data))
          .toList();
      users.addAll(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu");
    }
    return users;
  }

  Future<List<User>> getListUser(List<String> apis) async {
    List<User> users = List<User>();
    for (String api in apis) {
      print(api);
      final response = await http.get(api);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        User user =
            User.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
        users.add(user);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print("huhu");
      }
    }
    return users;
  }

  Future<User> updateUser(String apiUpdateMainUser, String object) async {
    print("hêhehehhehe " + object);
    final response = await http.put(apiUpdateMainUser,
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: object);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      _user =
          User.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
      print(_user.name);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu");
    }
    return _user;
  }
}
