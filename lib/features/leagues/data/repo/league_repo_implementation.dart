import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/helpers/generate_fixtures.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/services/firestorage_service.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';
import 'package:uuid/uuid.dart';

class LeaguesRepoImplementation implements LeaguesRepo {
  final FirestoreService _firestoreService;
  final FirestorageService _firestorageService;

  LeaguesRepoImplementation(this._firestoreService, this._firestorageService);

  @override
  Future<Either<Failure, Unit>> addLeague(
      String title,
      DateTime startDate,
      List<UserInformation> players,
      int totalPlayers,
      bool isHomeAndAway,
      XFile? image) async {
    try {
      if (players.length > totalPlayers) {
        return left(
          CustomFailure(errMessage: 'You’ve passed the total player number.'),
        );
      } else if (players.length < totalPlayers) {
        return left(
          CustomFailure(errMessage: 'Players number is still incomplete.'),
        );
      }
      var id = const Uuid().v4();
      String downloadUrl;
      if (image != null) {
        File selectedImagePath = File(image.path);
        downloadUrl = await _firestorageService.uploadFile(
            selectedImagePath, _firestorageService.leaguesFolderName, title);
      } else {
        return left(PickImageFailure(errMessage: 'choisir une image.'));
      }
      League event = League(
        id: id,
        title: title,
        downloadUrl: downloadUrl,
        startDate: Timestamp.fromDate(startDate),
        totalPlayers: totalPlayers,
        currentRound: 0,
        isHomeAndAway: isHomeAndAway,
      );
      await _firestoreService.addLeague(event, players);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> editLeague(League oldLeague, String newTitle,
      DateTime startDate, bool isOldImage, XFile? image) async {
    try {
      String downloadUrl;
      if (!isOldImage) {
        if (image != null) {
          await _firestorageService.deleteFile(
              _firestorageService.leaguesFolderName, oldLeague.title);
          File selectedImagePath = File(image.path);
          downloadUrl = await _firestorageService.uploadFile(selectedImagePath,
              _firestorageService.leaguesFolderName, newTitle);
        } else {
          return left(PickImageFailure(errMessage: 'error'));
        }
      } else {
        downloadUrl = await _firestorageService.updateFile(
            oldLeague.title, _firestorageService.leaguesFolderName, newTitle);
      }
      League l = League(
        id: oldLeague.id,
        title: newTitle,
        downloadUrl: downloadUrl,
        startDate: Timestamp.fromDate(startDate),
        totalPlayers: oldLeague.totalPlayers,
        currentRound: oldLeague.currentRound,
        isHomeAndAway: oldLeague.isHomeAndAway,
      );
      await _firestoreService.updateLeague(l);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }

  @override
  Future<Either<Failure, List<League>>> getLeagues() async {
    try {
      List<League> leaguesList = await _firestoreService.getLeagues();
      return right(leaguesList);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Player>>> getPlayers(League league) async {
    try {
      var playersList = await _firestoreService.getPlayers(league);
      return right(playersList);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, League>> genarateMatches(League league) async {
    try {
      List<Player> playersList = await _firestoreService.getPlayers(league);
      List<Fixture> generatedFixtures =
          generateFixtures(playersList, league.isHomeAndAway);

      generatedFixtures.sort((a, b) => a.round.compareTo(b.round));

      Map<int, List<Fixture>> matchesByRound = {};
      for (var match in generatedFixtures) {
        if (!matchesByRound.containsKey(match.round)) {
          matchesByRound[match.round] = [];
        }
        matchesByRound[match.round]!.add(match);
      }

      await _firestoreService.stockRounds(league, matchesByRound);
      League l = await _firestoreService.getLeague(league.id);
      return right(l);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteLeague(League league) async {
    try {
      await _firestoreService.deleteLeague(league);
      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Fixture>>> getMatches(
      League league, int round) async {
    try {
      List<Fixture> fixtures =
          await _firestoreService.getMatches(league, round);
      return right(fixtures);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }
}
