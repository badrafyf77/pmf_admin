import 'package:pmf_admin/core/utils/services/fireauth_service.dart';
import 'package:pmf_admin/core/utils/services/firestorage_service.dart';
import 'package:pmf_admin/core/utils/services/firestore_service.dart';
import 'package:pmf_admin/features/auth/data/repo/auth_repo_implementation.dart';
import 'package:get_it/get_it.dart';
import 'package:pmf_admin/features/home/data/repo/home_repo_implementation.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo_implementation.dart';
import 'package:pmf_admin/features/posts/data/repo/posts_repo_implementation.dart';
import 'package:pmf_admin/features/users/data/repo/users_repo_implementation.dart';

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
  getIt.registerSingleton<HomeRepoImplementation>(
    HomeRepoImplementation(
      getIt.get<FirestoreService>(),
    ),
  );
  getIt.registerSingleton<LeaguesRepoImplementation>(
    LeaguesRepoImplementation(
      getIt.get<FirestoreService>(),
      getIt.get<FirestorageService>(),
    ),
  );
  getIt.registerSingleton<UsersRepoImplementation>(
    UsersRepoImplementation(
      getIt.get<FirestoreService>(),
    ),
  );
  getIt.registerSingleton<PostsRepoImplementation>(
    PostsRepoImplementation(
      getIt.get<FirestoreService>(),
      getIt.get<FirestorageService>(),
    ),
  );
}
