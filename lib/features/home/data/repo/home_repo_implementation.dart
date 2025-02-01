import 'package:dartz/dartz.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/core/utils/failures.dart';
import 'package:pmf_admin/features/home/data/model/home_info.dart';
import 'package:pmf_admin/features/home/data/repo/home_repo.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeRepoImplementation implements HomeRepo {
  final FirestoreService _firestoreService;

  HomeRepoImplementation(this._firestoreService);

  @override
  Future<Either<Failure, HomeInfo>> getInfo(DateTime date) async {
    try {
      int leagues = await _firestoreService.countLeagues();
      int users = await _firestoreService.countUsers();
      int posts = await _firestoreService.countPosts();
      List visitsList =
          await _firestoreService.getVisitsList(date.month, date.year);
      int monthVisits = await _firestoreService.getMonthVisits();
      HomeInfo homeInfo = HomeInfo(
        leagues: leagues,
        users: users,
        posts: posts,
        monthVisits: monthVisits,
        visitsList: visitsList,
        date: date,
      );
      return right(homeInfo);
    } catch (e) {
      if (e is FirebaseException) {
        return left(FirestoreFailure.fromFirestoreFailure(e));
      }
      return left(FirestoreFailure(
          errMessage: 'il y a une erreur, veuillez réessayer'));
    }
  }
}
