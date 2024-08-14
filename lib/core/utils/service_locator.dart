import 'package:pmf_admin/core/utils/services/fireauth_service.dart';
import 'package:pmf_admin/core/utils/services/firestorage_service.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/features/auth/data/repo/auth_repo_implementation.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo_implementation.dart';
import 'package:pmf_admin/features/home/data/repo/home_repo_implementation.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirestoreService>(
    FirestoreService(),
  );
  getIt.registerSingleton<FirestorageService>(
    FirestorageService(),
  );
  getIt.registerSingleton<FireauthService>(
    FireauthService(),
  );
  getIt.registerSingleton<AuthRepoImplementation>(
    AuthRepoImplementation(
      getIt.get<FireauthService>(),
    ),
  );
  getIt.registerSingleton<EventsRepoImplementation>(
    EventsRepoImplementation(
      getIt.get<FirestoreService>(),
      getIt.get<FirestorageService>(),
    ),
  );
  getIt.registerSingleton<HomeRepoImplementation>(
    HomeRepoImplementation(
      getIt.get<FirestoreService>(),
    ),
  );
}
