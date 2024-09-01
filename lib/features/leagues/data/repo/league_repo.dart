import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

abstract class LeaguesRepo {
  Future<Either<Failure, List<League>>> getLeagues();
  Future<Either<Failure, List<Player>>> getPlayers(League league);
  Future<Either<Failure, Unit>> addLeague(String title, DateTime startDate,
      List<UserInformation> players, int totalPlayers, XFile? image);
  Future<Either<Failure, Unit>> editLeague(League oldLeague, String newTitle, DateTime startDate, bool isOldImage, XFile? image);
  Future<Either<Failure, Unit>> deleteLeague(League league);
  Future<Either<Failure, League>> genarateMatches(League league);
}
