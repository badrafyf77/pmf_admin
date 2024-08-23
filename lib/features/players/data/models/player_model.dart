class Player {
  final String id;
  final String displayName;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final int scored;
  final int conceded;
  final int goalDef;
  final int pts;

  Player({
    required this.id,
    required this.displayName,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.scored,
    required this.conceded,
    required this.goalDef,
    required this.pts,
  });

  Player.fromJson(json)
      : this(
          id: json['id'] as String,
          displayName: json['displayName'] as String,
          played: json['played'] as int,
          wins: json['wins'] as int,
          draws: json['draws'] as int,
          losses: json['losses'] as int,
          scored: json['scored'] as int,
          conceded: json['conceded'] as int,
          goalDef: json['goalDef'] as int,
          pts: json['pts'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'played': played,
      'wins': wins,
      'draws': draws,
      'losses': losses,
      'scored': scored,
      'conceded': conceded,
      'goalDef': goalDef,
      'pts': pts,
    };
  }
}