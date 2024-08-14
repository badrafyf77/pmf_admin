import 'package:dartz/dartz.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:image_picker/image_picker.dart';

abstract class EventsRepo {
  Future<Either<Failure, Unit>> addEvent(String title, String description,
      String place, DateTime date, XFile? image);
  Future<Either<Failure, Unit>> updateEvent(
      League event, String oldTitle, bool oldImage, XFile? image);
  Future<Either<Failure, Unit>> setInitialEvent(League event);
  Future<Either<Failure, Unit>> deleteEvent(League event);
}
