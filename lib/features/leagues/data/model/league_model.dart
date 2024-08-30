import 'package:cloud_firestore/cloud_firestore.dart';

class League {
  final String id;
  final String title;
  final String downloadUrl;
  final Timestamp startDate;
  final int playersNumbers;
  final int totalPlayers;
  final int currentRound;

  League({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.startDate,
    required this.playersNumbers,
    required this.totalPlayers,
    required this.currentRound,
  });

  League.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          downloadUrl: json['downloadUrl'] as String,
          startDate: json['startDate'] as Timestamp,
          playersNumbers: json['playersNumbers'] as int,
          totalPlayers: json['totalPlayers'] as int,
          currentRound: json['currentRound'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'startDate': startDate,
      'playersNumbers': playersNumbers,
      'totalPlayers': totalPlayers,
      'currentRound': currentRound,
    };
  }
}
