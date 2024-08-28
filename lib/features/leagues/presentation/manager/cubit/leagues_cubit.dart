import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesRepo _leaguesRepo;
  LeaguesCubit(this._leaguesRepo) : super(LeaguesInitial());

  Future<void> addLeague(String title, DateTime startDate,
      List<UserInformation> players, XFile? image) async {
    emit(Leagueslaoding());
    var result = await _leaguesRepo.addLeague(title, startDate, players, image);
    result.fold((left) {
      emit(LeaguesFailure(err: left.errMessage));
    }, (right) {
      emit(LeaguesSuccess());
    });
  }
}
