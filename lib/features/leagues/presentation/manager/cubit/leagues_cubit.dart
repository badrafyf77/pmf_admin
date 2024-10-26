import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesRepo _leaguesRepo;
  LeaguesCubit(this._leaguesRepo) : super(LeaguesInitial());

  Future<void> addLeague(
      String title,
      DateTime startDate,
      List<UserInformation> players,
      int totalPlayers,
      bool isHomeAndAway,
      XFile? image) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.addLeague(
        title, startDate, players, totalPlayers, isHomeAndAway, image);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(LeaguesSuccess());
    });
  }

  Future<void> updateLeague(League oldLeague, String newTitle,
      DateTime startDate, bool isOldImage, XFile? image) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.editLeague(
        oldLeague, newTitle, startDate, isOldImage, image);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(LeaguesSuccess());
    });
  }

  Future<void> deleteLeague(League league) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.deleteLeague(league);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(LeaguesSuccess());
    });
  }

  Future<void> getLeagues() async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.getLeagues();
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(GetLeaguesSuccess(leaguesList: right));
    });
  }

  Future<void> getPlayers(League league) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.getPlayers(league);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(GetPlayersSuccess(playersList: right));
    });
  }

  Future<void> changePlayer(League league, UserInformation newUser, Player oldPlayer) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.changePlayer(league, newUser, oldPlayer);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(LeaguesSuccess());
    });
  }

  Future<void> getMatches(League league, int round) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.getMatches(league, round);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(GetMatchesSuccess(fixtures: right));
    });
  }

  Future<void> generateMatches(League league) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.genarateMatches(league);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(GenerateMatchesSuccess(league: right));
    });
  }

  Future<void> editFixture(
      League league, Fixture fixture, int homeGoals, int awayGoals) async {
    emit(Leagueslaoding());
    var result =
        await _leaguesRepo.editMatch(league, fixture, homeGoals, awayGoals);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(EditMatchSuccess(data: right));
    });
  }
}
