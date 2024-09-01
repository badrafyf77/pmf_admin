import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

class FirestoreService {
  CollectionReference leagues =
      FirebaseFirestore.instance.collection('leagues');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference visits = FirebaseFirestore.instance.collection('visits');

  Future<List<UserInformation>> getUsers() async {
    List<UserInformation> usersList = [];
    await users.orderBy('joinedDate', descending: true).get().then((user) {
      for (var doc in user.docs) {
        usersList.add(UserInformation.fromJson(doc));
      }
    });
    return usersList;
  }

  Future<List<League>> getLeagues() async {
    List<League> leaguesList = [];
    await leagues.orderBy('startDate', descending: true).get().then((league) {
      for (var doc in league.docs) {
        leaguesList.add(League.fromJson(doc));
      }
    });
    return leaguesList;
  }

  Future<League> getLeague(String id) async {
    dynamic data;
    League league;
    await leagues
        .doc(id)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data();
    });
    league = League.fromJson(data);
    return league;
  }

  Future<void> addLeague(League league, List<UserInformation> usersList) async {
    await leagues.doc(league.id).set(league.toJson());
    for (var element in usersList) {
      Player p = Player(
        id: element.id,
        displayName: element.displayName,
        played: 0,
        wins: 0,
        draws: 0,
        losses: 0,
        scored: 0,
        conceded: 0,
        goalDef: 0,
        pts: 0,
      );
      await leagues
          .doc(league.id)
          .collection("players")
          .doc(p.id)
          .set(p.toJson());
    }
  }

  Future<void> updateLeague(League league) async {
    await leagues.doc(league.id).update(league.toJson());
  }

  Future<List<Player>> getPlayers(League league) async {
    List<Player> playersList = [];

    var snapshot = await leagues.doc(league.id).collection('players').get();

    for (var doc in snapshot.docs) {
      playersList.add(Player.fromJson(doc.data()));
    }

    return playersList;
  }

  Future<void> stockRounds(
      League league, Map<int, List<Fixture>> fixturesByRound) async {
    for (var i = 0; i < fixturesByRound.length; i++) {
      int roundNumber = fixturesByRound.keys.elementAt(i);
      List<Fixture> fixturesList = fixturesByRound[roundNumber]!;

      for (var j = 0; j < fixturesList.length; j++) {
        Fixture fixture = fixturesList[j];
        await leagues
            .doc(league.id)
            .collection("round-$roundNumber")
            .doc('fixture-${fixture.homeName}-vs-${fixture.awayName}')
            .set(fixture.toJson());
      }
    }
    await changeCurrentRound(league, 1);
  }

  Future<void> changeCurrentRound(League league, int round) async {
    await leagues.doc(league.id).update({'currentRound': round});
  }
}
