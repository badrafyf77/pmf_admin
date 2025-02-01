class Group {
  final String id;
  final String title;
  final int totalPlayers;
  final int currentRound;

  Group({
    required this.id,
    required this.title,
    required this.totalPlayers,
    required this.currentRound,
  });

  Group.fromJson(json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          totalPlayers: json['totalPlayers'] as int,
          currentRound: json['currentRound'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'totalPlayers': totalPlayers,
      'currentRound': currentRound,
    };
  }
}
