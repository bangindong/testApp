import 'dart:async';
import 'dart:convert';
import 'models/models.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Comment _comment;

  Future<Comment> getComment(String api) async {
    final response = await http.get(api);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      _comment = Comment.fromJson(
          Map<String, dynamic>.from(jsonDecode(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu_commment");
    }
    return _comment;
  }

  Future<List<Comment>> getAllComment(String api) async {
    final response = await http.get(api);
    List<Comment> comments = List<Comment>();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var list = (jsonDecode(response.body) as List)
          .map((data) => Comment.fromJson(data))
          .toList();
      comments.addAll(list);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu_commment");
    }
    return comments;
  }

  Future<List<Comment>> getListComment(List<String> apis) async {
    List<Comment> comments = List<Comment>();
    for (String api in apis) {
      print(api);
      final response = await http.get(api);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Comment comment = Comment.fromJson(Map<String, dynamic>.from(
            jsonDecode(utf8.decode(response.bodyBytes))));
        comments.add(comment);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print("huhu_commment");
      }
    }
    return comments;
  }

  Future<Comment> addComment(String api, String object) async {
    print(api);
    final response = await http.post(api,
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: object);
    print(response.statusCode);
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      _comment = Comment.fromJson(
          Map<String, dynamic>.from(jsonDecode(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu_commment");
    }
    return _comment;
  }
}
