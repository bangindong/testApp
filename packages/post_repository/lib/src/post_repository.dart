import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/models.dart';

class PostRepository {
  Post _post;

  Future<Post> getPost(String api) async {
    final response = await http.get(api);
    print(api);
    if (response.statusCode == 200) {
      _post =
          Post.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
      print(_post.postId);
    } else {
      print("huhu");
    }
    return _post;
  }

  Future<List<Post>> getListPosts(List<String> apis) async {
    List<Post> posts = List<Post>();
    for (String api in apis) {
      print(api);
      final response = await http.get(api);
      if (response.statusCode == 200) {
        print("post" + response.body);
        var post = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
            .map((data) => Post.fromJson((data)))
            .toList();
        posts.addAll(post);
      } else {
        print("huhu_post_getAll");
      }
    }
    return posts;
  }

  Future<List<Post>> getListPostsMain(String api) async {
    List<Post> posts = List<Post>();
    print(api);
    final response = await http.get(api);
    if (response.statusCode == 200) {
      print("post" + response.body);
      var post = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((data) => Post.fromJson((data)))
          .toList();
      posts.addAll(post);
    } else {
      print("huhu_post_getAll");
    }
    return posts;
  }

  Future<Post> addPost(String updatePostApi, String object) async {
    print(updatePostApi);
    Post _post;
    final response = await http.post(updatePostApi,
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: object);
    print(response.statusCode);
    if (response.statusCode == 201) {
      print(response.body);
      _post =
          Post.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
    } else {
      print("huhu_post_add_false");
    }
    return _post;
  }

  Future<Post> updatePost(String updatePostApi, String object) async {
    print(updatePostApi);
    Post _post;
    final response = await http.put(updatePostApi,
        headers: <String, String>{
          'content-type': 'application/json',
        },
        body: object);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      _post =
          Post.fromJson(Map<String, dynamic>.from(jsonDecode(response.body)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("huhu_post_update_false");
    }
    return _post;
  }
}
