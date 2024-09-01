import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:uuid/uuid.dart';

List<Fixture> generateFixtures(List<Player> players, bool isHomeAndAway) {
  List<Fixture> fixtures = [];
  int numTeams = players.length;
  int rounds = numTeams - 1;

  for (int round = 0; round < rounds; round++) {
    for (int i = 0; i < numTeams / 2; i++) {
      int home = (round + i) % (numTeams - 1);
      int away = (numTeams - 1 - i + round) % (numTeams - 1);

      if (i == 0) {
        away = numTeams - 1;
      }

      fixtures.add(
        Fixture(
          id: const Uuid().v4(),
          homeId: players[home].id,
          homeName: players[home].displayName,
          homeGoals: 0,
          awayId: players[away].id,
          awayName: players[away].displayName,
          awayGoals: 0,
          round: round + 1,
          isPlayed: false,
        ),
      );

      if (isHomeAndAway) {
        fixtures.add(
          Fixture(
            id: const Uuid().v4(),
            homeId: players[home].id,
            homeName: players[home].displayName,
            homeGoals: 0,
            awayId: players[away].id,
            awayName: players[away].displayName,
            awayGoals: 0,
            round: rounds + round + 1,
            isPlayed: false,
          ),
        );
      }
    }
  }

  return fixtures;
}
