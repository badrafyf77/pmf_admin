import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/service_locator.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/dashboard_screen.dart';
import 'package:pmf_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:pmf_admin/features/leagues/data/repo/league_repo_implementation.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/add_league_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/edit_league_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/league_matches_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/league_table_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/leagues_view.dart';
import 'package:pmf_admin/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pmf_admin/features/users/data/repo/users_repo_implementation.dart';
import 'package:pmf_admin/features/users/presentation/manager/get%20users%20cubit/get_users_cubit.dart';
import 'package:pmf_admin/features/users/presentation/views/users_view.dart';

class AppRouter {
  static const signIn = "/k";
  static const home = '/';
  static const leagues = '/leagues';
  static const addLeague = '/add-league';
  static const leagueTable = '/league-table';
  static const leagueMatches = '/league-matches';
  static const editEvent = '/editEvent';
  static const users = '/users';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: signIn,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: SignInView(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return DashboardScreen(body: child);
        },
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: leagues,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => LeaguesCubit(
                  getIt.get<LeaguesRepoImplementation>(),
                )..getLeagues(),
                child: const LeaguesView(),
              ),
            ),
          ),
          GoRoute(
            path: addLeague,
            pageBuilder: (context, state) => NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => GetUsersCubit(
                      getIt.get<UsersRepoImplementation>(),
                    )..getUsers(),
                  ),
                  BlocProvider(
                    create: (context) => LeaguesCubit(
                      getIt.get<LeaguesRepoImplementation>(),
                    ),
                  ),
                ],
                child: const AddLeagueView(),
              ),
            ),
          ),
          GoRoute(
            path: leagueTable,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LeagueTableView(),
            ),
          ),
          GoRoute(
            path: leagueMatches,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LeagueMatchesView(),
            ),
          ),
          GoRoute(
            path: editEvent,
            pageBuilder: (context, state) {
              League event = state.extra as League;
              return NoTransitionPage(
                child: EditEventView(
                  event: event,
                ),
              );
            },
          ),
          GoRoute(
            path: users,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => GetUsersCubit(
                  getIt.get<UsersRepoImplementation>(),
                )..getUsers(),
                child: const UsersView(),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  static void navigateTo(BuildContext context, String path) {
    GoRouter.of(context).go(path);
  }

  static void navigateToWithExtra(
      BuildContext context, String path, Object extra) {
    GoRouter.of(context).go(path, extra: extra);
  }

  static void navigateOff(BuildContext context, String path) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    context.pushReplacement(path);
  }

  static void pop(BuildContext context) {
    context.pop();
  }
}
