import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String email;
  final String displayName;
  final Timestamp joinedDate;
  final int leagueRank;
  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;
  // final int trophies;
  // final String downloadUrl;

  Player({
    required this.id,
    required this.email,
    required this.displayName,
    required this.joinedDate,
    required this.leagueRank,
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
  });

  Player.fromJson(json)
      : this(
          id: json['id'] as String,
          email: json['email'] as String,
          displayName: json['displayName'] as String,
          joinedDate: json['joinedDate'] as Timestamp,
          leagueRank: json['leagueRank'] as int,
          matchesPlayed: json['matchesPlayed'] as int,
          wins: json['wins'] as int,
          draws: json['draws'] as int,
          losses: json['losses'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'joinedDate': joinedDate,
      'leagueRank': leagueRank,
      'matchesPlayed': matchesPlayed,
      'wins': wins,
      'draws': draws,
      'losses': losses,
    };
  }
}
