import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String description;
  final String downloadUrl;
  final Timestamp date;

  Post({
    required this.id,
    required this.description,
    required this.downloadUrl,
    required this.date,
  });

  Post.fromJson(json)
      : this(
          id: json['id'] as String,
          description: json['description'] as String,
          downloadUrl: json['downloadUrl'] as String,
          date: json['date'] as Timestamp,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'downloadUrl': downloadUrl,
      'date': date,
    };
  }
}
