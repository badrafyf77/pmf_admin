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

List<Player> leaguePlayers = [
  Player(
      id: '1',
      displayName: "John Doe",
      played: 20,
      wins: 12,
      draws: 5,
      losses: 3,
      scored: 30,
      conceded: 15,
      goalDef: 15,
      pts: 41),
  Player(
      id: '2',
      displayName: "Jane Smith",
      played: 20,
      wins: 10,
      draws: 7,
      losses: 3,
      scored: 25,
      conceded: 18,
      goalDef: 7,
      pts: 37),
  Player(
      id: '3',
      displayName: "Alex Johnson",
      played: 20,
      wins: 8,
      draws: 8,
      losses: 4,
      scored: 20,
      conceded: 14,
      goalDef: 6,
      pts: 32),
  Player(
      id: '4',
      displayName: "Chris Brown",
      played: 20,
      wins: 14,
      draws: 3,
      losses: 3,
      scored: 35,
      conceded: 12,
      goalDef: 23,
      pts: 45),
];

List<Player> groupPlayers = [
  Player(
      id: '1',
      displayName: "John Doe",
      played: 20,
      wins: 12,
      draws: 5,
      losses: 3,
      scored: 30,
      conceded: 15,
      goalDef: 15,
      pts: 41),
  Player(
      id: '2',
      displayName: "Jane Smith",
      played: 20,
      wins: 10,
      draws: 7,
      losses: 3,
      scored: 25,
      conceded: 18,
      goalDef: 7,
      pts: 37),
  Player(
      id: '3',
      displayName: "Alex Johnson",
      played: 20,
      wins: 8,
      draws: 8,
      losses: 4,
      scored: 20,
      conceded: 14,
      goalDef: 6,
      pts: 32),
  Player(
      id: '4',
      displayName: "Chris Brown",
      played: 20,
      wins: 14,
      draws: 3,
      losses: 3,
      scored: 35,
      conceded: 12,
      goalDef: 23,
      pts: 45),
];
