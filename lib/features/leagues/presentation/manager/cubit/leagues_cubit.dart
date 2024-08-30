import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesRepo _leaguesRepo;
  LeaguesCubit(this._leaguesRepo) : super(LeaguesInitial());

  Future<void> addLeague(String title, DateTime startDate,
      List<UserInformation> players, int totalPlayers, XFile? image) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.addLeague(
        title, startDate, players, totalPlayers, image);
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

  Future<void> generateMatches(League league) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.genarateMatches(league);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(GenerateMatchesSuccess(league: right));
    });
  }
}
