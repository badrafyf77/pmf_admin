import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';
import 'package:pmf_admin/features/users/data/repo/users_repo.dart';

class UsersRepoImplementation implements UsersRepo {
  final FirestoreService _firestoreService;

  UsersRepoImplementation(this._firestoreService);

  @override
  Future<Either<Failure, List<UserInformation>>> getUsers() async {
    try {
      List<UserInformation> usersList = await _firestoreService.getUsers();
      return right(usersList);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(errMessage: e.toString()));
    }
  }
}
