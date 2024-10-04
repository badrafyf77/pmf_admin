import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation {
  final String id;
  final String displayName;
  final String email;
  final Timestamp joinedDate;
  final int leagueRanking;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final List<String> participations;

  UserInformation({
    required this.id,
    required this.displayName,
    required this.email,
    required this.joinedDate,
    required this.leagueRanking,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.participations,
  });

  UserInformation.fromJson(json)
      : this(
          id: json['id'] as String,
          displayName: json['displayName'] as String,
          email: json['email'] as String,
          joinedDate: json['joinedDate'] as Timestamp,
          leagueRanking: json['leagueRanking'] as int,
          played: json['played'] as int,
          wins: json['wins'] as int,
          draws: json['draws'] as int,
          losses: json['losses'] as int,
          participations: List<String>.from(json['participations'] ?? []),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'joinedDate': joinedDate,
      'leagueRanking': leagueRanking,
      'played': played,
      'wins': wins,
      'draws': draws,
      'losses': losses,
      'participations': participations,
    };
  }
}
