import 'package:cloud_firestore/cloud_firestore.dart';

class League {
  final String id;
  final String title;
  final String downloadUrl;
  final Timestamp startDate;
  final int totalPlayers;
  final int currentRound;
  final bool isHomeAndAway;

  League({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.startDate,
    required this.totalPlayers,
    required this.currentRound,
    required this.isHomeAndAway,
  });

  League.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          downloadUrl: json['downloadUrl'] as String,
          startDate: json['startDate'] as Timestamp,
          totalPlayers: json['totalPlayers'] as int,
          currentRound: json['currentRound'] as int,
          isHomeAndAway: json['isHomeAndAway'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'startDate': startDate,
      'totalPlayers': totalPlayers,
      'currentRound': currentRound,
      'isHomeAndAway': isHomeAndAway,
    };
  }
}
