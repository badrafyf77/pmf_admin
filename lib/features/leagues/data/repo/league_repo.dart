import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';

abstract class LeaguesRepo {
  Future<Either<Failure, Unit>> addLeague(String title, DateTime startDate,
      List<UserInformation> players, XFile? image);
  // Future<Either<Failure, Unit>> updateEvent(
  //     League event, String oldTitle, bool oldImage, XFile? image);
  // Future<Either<Failure, Unit>> setInitialEvent(League event);
  // Future<Either<Failure, Unit>> deleteEvent(League event);
}
