import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<UserInformation>>> getUsers();
  // Future<Either<Failure, Unit>> deteleUser();
}
