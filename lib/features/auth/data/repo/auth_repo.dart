import 'package:dartz/dartz.dart';
import '../../../../core/utils/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, Unit>> signIn(String email, String password);
}