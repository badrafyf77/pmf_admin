import 'package:cloud_firestore/cloud_firestore.dart';

class League {
  final String id;
  final String title;
  final String downloadUrl;
  final Timestamp startDate;
  final int players;
  final int currentFixture;

  League({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.startDate,
    required this.players,
    required this.currentFixture,
  });

  League.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          downloadUrl: json['downloadUrl'] as String,
          startDate: json['startDate'] as Timestamp,
          players: json['players'] as int,
          currentFixture: json['currentFixture'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'startDate': startDate,
      'players': players,
      'currentFixture': currentFixture,
    };
  }
}
