class Fixture {
  final String id;
  final int round;
  final String homeId;
  final String homeName;
  final int homeGoals;
  final String awayId;
  final String awayName;
  final int awayGoals;
  final bool isPlayed;

  Fixture({
    required this.id,
    required this.round,
    required this.homeId,
    required this.homeName,
    required this.homeGoals,
    required this.awayId,
    required this.awayName,
    required this.awayGoals,
    required this.isPlayed,
  });

  Fixture.fromJson(json)
      : this(
          id: json['id'] as String,
          round: json['round'] as int,
          homeId: json['homeId'] as String,
          homeName: json['homeName'] as String,
          homeGoals: json['homeGoals'] as int,
          awayId: json['awayId'] as String,
          awayName: json['awayName'] as String,
          awayGoals: json['awayGoals'] as int,
          isPlayed: json['isPlayed'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'round': round,
      'homeId': homeId,
      'homeName': homeName,
      'homeGoals': homeGoals,
      'awayId': awayId,
      'awayName': awayName,
      'awayGoals': awayGoals,
      'isPlayed': isPlayed,
    };
  }
}
