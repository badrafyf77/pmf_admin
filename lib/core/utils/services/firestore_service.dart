import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';

class FirestoreService {
  final String playersCollection = "players";
  final String participations = "participations";
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

  Future<UserInformation> getUser(String id) async {
    dynamic data;
    UserInformation user;
    await users.doc(id).get().then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data();
    });
    user = UserInformation.fromJson(data);
    return user;
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

  Future<List<Fixture>> getMatches(League league, int round) async {
    List<Fixture> fixtures = [];

    var snapshot =
        await leagues.doc(league.id).collection('round-$round').get();

    for (var doc in snapshot.docs) {
      fixtures.add(Fixture.fromJson(doc.data()));
    }

    return fixtures;
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
      await addPlayer(league.id, element);
    }
  }

  Future<void> updateLeague(League league) async {
    await leagues.doc(league.id).update(league.toJson());
  }

  Future<void> deleteLeague(League league) async {
    var playersSnapshots =
        await leagues.doc(league.id).collection(playersCollection).get();
    for (var doc in playersSnapshots.docs) {
      await doc.reference.delete();
    }
    if (league.currentRound > 0) {
      final instance = FirebaseFirestore.instance;
      final batch = instance.batch();
      var collection = leagues.doc(league.id).collection(playersCollection);
      var roundsSnapshots = await collection.get();
      for (var doc in roundsSnapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
    List<Player> players = await getPlayers(league);
    for (var player in players) {
      await deleteParticipationId(player.id, league.id);
    }
    await leagues.doc(league.id).delete();
  }

  Future<List<Player>> getPlayers(League league) async {
    List<Player> playersList = [];

    var snapshot =
        await leagues.doc(league.id).collection(playersCollection).get();

    for (var doc in snapshot.docs) {
      playersList.add(Player.fromJson(doc.data()));
    }

    return playersList;
  }

  Future<Player> getPlayer(String leagueId, String playerId) async {
    dynamic data;
    Player player;
    await leagues
        .doc(leagueId)
        .collection(playersCollection)
        .doc(playerId)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data();
    });
    player = Player.fromJson(data);
    return player;
  }

  Future<void> addPlayer(String leagueId, UserInformation user,
      {Player? oldPlayer}) async {
    Player p;
    if (oldPlayer == null) {
      p = Player(
        id: user.id,
        displayName: user.displayName,
        played: 0,
        wins: 0,
        draws: 0,
        losses: 0,
        scored: 0,
        conceded: 0,
        goalDef: 0,
        pts: 0,
      );
    } else {
      p = Player(
        id: user.id,
        displayName: user.displayName,
        played: oldPlayer.played,
        wins: oldPlayer.wins,
        draws: oldPlayer.draws,
        losses: oldPlayer.losses,
        scored: oldPlayer.scored,
        conceded: oldPlayer.conceded,
        goalDef: oldPlayer.goalDef,
        pts: oldPlayer.pts,
      );
    }
    await leagues
        .doc(leagueId)
        .collection(playersCollection)
        .doc(p.id)
        .set(p.toJson());
    await addParticipationId(p.id, leagueId);
  }

  Future<void> deletePlayer(String leagueId, String playerId) async {
    await leagues
        .doc(leagueId)
        .collection(playersCollection)
        .doc(playerId)
        .delete();
    await deleteParticipationId(playerId, leagueId);
  }

  Future<void> changePlayer(
      League league, UserInformation newUser, Player oldPlayer) async {
    //nbedel id o smiya f ga3 rounds
    int maxRounds = (league.totalPlayers - 1) * (league.isHomeAndAway ? 2 : 1);
    for (var i = 1; i <= maxRounds; i++) {
      List<Fixture> fixtures = await getMatches(league, i);
      for (var element in fixtures) {
        if (!element.isPlayed) {
          if (element.homeId == oldPlayer.id) {
            await leagues
                .doc(league.id)
                .collection('round-$i')
                .doc(element.id)
                .update({
              'homeId': newUser.id,
              'homeName': newUser.displayName,
            });
          } else if (element.awayId == oldPlayer.id) {
            await leagues
                .doc(league.id)
                .collection('round-$i')
                .doc(element.id)
                .update({
              'awayId': newUser.id,
              'awayName': newUser.displayName,
            });
          }
        }
      }
    }
    //nbedel player db mn league
    await deletePlayer(league.id, oldPlayer.id);
    await addPlayer(league.id, newUser, oldPlayer: oldPlayer);
  }

  Future<void> addParticipationId(String userId, String participationId) async {
    users.doc(userId).update({
      participations: FieldValue.arrayUnion([participationId])
    });
  }

  Future<void> deleteParticipationId(
      String userId, String participationId) async {
    users.doc(userId).update({
      participations: FieldValue.arrayRemove([participationId])
    });
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
            .doc(fixture.id)
            .set(fixture.toJson());
      }
    }
    await changeCurrentRound(league, 1);
  }

  Future<void> changeCurrentRound(League league, int round) async {
    if (round > league.currentRound) {
      await leagues.doc(league.id).update({'currentRound': round});
    }
  }

  Future<bool> checkIsRoundComplete(League league, int round) async {
    List<Fixture> fixtures = await getMatches(league, round);
    for (var element in fixtures) {
      if (!element.isPlayed) {
        return false;
      }
    }
    await changeCurrentRound(league, round);
    return true;
  }

  // Function to update the player stats based on the new fixture result
  Future<void> updatePlayerStats(
      League league, String playerId, int playerGoals, int oppoGoals) async {
    Player player = await getPlayer(league.id, playerId);

    int wins = player.wins;
    int draws = player.draws;
    int losses = player.losses;
    int pts = player.pts;

    if (playerGoals > oppoGoals) {
      wins += 1;
      pts += 3;
    } else if (playerGoals < oppoGoals) {
      losses += 1;
    } else {
      draws += 1;
      pts += 1;
    }

    Player updatedPlayer = player.copyWith(
      played: player.played + 1,
      wins: wins,
      draws: draws,
      losses: losses,
      scored: player.scored + playerGoals,
      conceded: player.conceded + oppoGoals,
      goalDef: (player.scored + playerGoals) - (player.conceded + oppoGoals),
      pts: pts,
    );

    await _updatePlayerInDatabase(league.id, updatedPlayer);
    await _updateUserInformation(playerId, playerGoals, oppoGoals);
  }

  // Function to reverse the old player stats
  Future<void> reversePlayerStats(
      League league, String playerId, int playerGoals, int oppoGoals) async {
    Player player = await getPlayer(league.id, playerId);

    int wins = player.wins;
    int draws = player.draws;
    int losses = player.losses;
    int pts = player.pts;

    if (playerGoals > oppoGoals) {
      wins -= 1;
      pts -= 3;
    } else if (playerGoals < oppoGoals) {
      losses -= 1;
    } else {
      draws -= 1;
      pts -= 1;
    }

    Player updatedPlayer = player.copyWith(
      played: player.played - 1,
      wins: wins,
      draws: draws,
      losses: losses,
      scored: player.scored - playerGoals,
      conceded: player.conceded - oppoGoals,
      goalDef: (player.scored - playerGoals) - (player.conceded - oppoGoals),
      pts: pts,
    );

    await _updatePlayerInDatabase(league.id, updatedPlayer);
    await _updateUserInformation(playerId, playerGoals, oppoGoals,
        isReversing: true);
  }

// Helper function to update player in the database
  Future<void> _updatePlayerInDatabase(String leagueId, Player player) async {
    await leagues
        .doc(leagueId)
        .collection(playersCollection)
        .doc(player.id)
        .update(player.toJson());
  }

// Helper function to update user information
  Future<void> _updateUserInformation(
      String playerId, int playerGoals, int oppoGoals,
      {bool isReversing = false}) async {
    UserInformation userInformation = await getUser(playerId);

    int playedChange = isReversing ? -1 : 1;
    int winsChange = playerGoals > oppoGoals ? playedChange : 0;
    int drawsChange = playerGoals == oppoGoals ? playedChange : 0;
    int lossesChange = playerGoals < oppoGoals ? playedChange : 0;

    await users.doc(playerId).update({
      'wins': userInformation.wins + winsChange,
      'draws': userInformation.draws + drawsChange,
      'losses': userInformation.losses + lossesChange,
      'played': userInformation.played + playedChange,
    });
  }

// Function to edit a fixture and update player stats
  Future<void> editFixture(
      League league, Fixture oldFixture, int homeGoals, int awayGoals) async {
    // Reverse old stats
    if (oldFixture.isPlayed) {
      await reversePlayerStats(league, oldFixture.homeId, oldFixture.homeGoals,
          oldFixture.awayGoals);
      await reversePlayerStats(league, oldFixture.awayId, oldFixture.awayGoals,
          oldFixture.homeGoals);
    }

    // Create new fixture with updated goals
    Fixture newFixture = oldFixture.copyWith(
      homeGoals: homeGoals,
      awayGoals: awayGoals,
      isPlayed: true,
    );

    // Update fixture in the database
    await leagues
        .doc(league.id)
        .collection("round-${oldFixture.round}")
        .doc(oldFixture.id)
        .update(newFixture.toJson());

    // Apply new stats
    await updatePlayerStats(league, oldFixture.homeId, homeGoals, awayGoals);
    await updatePlayerStats(league, oldFixture.awayId, awayGoals, homeGoals);

    // Check if the round is complete
    await checkIsRoundComplete(league, oldFixture.round);
  }
}

//---------TEST----------
//---------TEST----------
//---------TEST----------
Future<void> addParticipationsFieldToUsers() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get all users from the players collection
  var usersSnapshot = await firestore.collection('users').get();

  for (var doc in usersSnapshot.docs) {
    var userData = doc.data();

    // Check if the participations field is missing
    if (!userData.containsKey('participations')) {
      // Add an empty participations field
      await firestore.collection('users').doc(doc.id).update({
        'participations': [] // Set an empty array for participations
      });
    }
  }

  // ignore: avoid_print
  print("Complete");
}

Future<void> convertEmailsToLowerCase() async {
  // Reference to Firestore 'users' collection
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Get all documents in the collection
  QuerySnapshot snapshot = await usersCollection.get();

  // Iterate through each document
  for (QueryDocumentSnapshot document in snapshot.docs) {
    Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

    // Check if email field exists and is a string
    if (userData.containsKey('email') && userData['email'] is String) {
      String email = userData['email'];

      // Convert the email to lowercase
      String lowerCaseEmail = email.toLowerCase();

      // Update the document with the lowercase email
      await usersCollection.doc(document.id).update({'email': lowerCaseEmail});
    }
  }

  // ignore: avoid_print
  print("Complete");
}
