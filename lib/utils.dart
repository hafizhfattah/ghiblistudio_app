// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

//Service
Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://ghibliapi.herokuapp.com/films/'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

//More Service
List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

//Class Model
class Post {
  String score;
  String image;
  String title;
  String description;
  dynamic locations;

  Post({
    required this.score,
    required this.image,
    required this.title,
    required this.description,
    required this.locations,
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        score: json["rt_score"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        locations: json["people"][0],
      );
}
