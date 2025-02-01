import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/features/home/data/model/home_info.dart';

abstract class HomeRepo {
  Future<Either<Failure, HomeInfo>> getInfo(DateTime date);
}
