import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id = "";
  String title = "";
  String body = "";
  String author = "";
  String image = "";
  String pdf = "";
  DateTime date = DateTime.now();

  Post({
    this.id = '',
    required this.title,
    required this.body,
    required this.author,
    required this.date,
    required this.image,
    required this.pdf,
  });

  static Post fromJson(Map<String, dynamic> json, String id) => Post(
        id: id,
        title: json['title'],
        body: json['body'],
        author: json['author'],
        date: (json['date'] as Timestamp).toDate(),
        image: json['image'],
        pdf: json['pdf'],
      );
}
