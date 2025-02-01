import 'package:cloud_firestore/cloud_firestore.dart';

class Cup {
  final String id;
  final String title;
  final String downloadUrl;
  final Timestamp startDate;
  final int totalPlayers;
  final int nbrGroups;

  Cup({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.startDate,
    required this.totalPlayers,
    required this.nbrGroups,
  });

  Cup.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          downloadUrl: json['downloadUrl'] as String,
          startDate: json['startDate'] as Timestamp,
          totalPlayers: json['totalPlayers'] as int,
          nbrGroups: json['nbrGroups'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'downloadUrl': downloadUrl,
      'startDate': startDate,
      'totalPlayers': totalPlayers,
      'nbrGroups': nbrGroups,
    };
  }
}
