import 'package:cloud_firestore/cloud_firestore.dart';

class League {
  final String id;
  final String title;
  final String downloadUrl;
  final Timestamp startDate;
  List<String> players;

  League({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.startDate,
    required this.players,
  });

  League.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          downloadUrl: json['downloadUrl'] as String,
          startDate: json['startDate'] as Timestamp,
          players: json['players'] as List<String>,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'startDate': startDate,
      'players': players,
    };
  }
}
