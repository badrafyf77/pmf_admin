import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/dashboard_screen.dart';
import 'package:pmf_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/add_league_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/edit_league_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/league_matches_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/league_table_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/leagues_view.dart';
import 'package:pmf_admin/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pmf_admin/features/players/presentation/views/players_view.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    ),
  );
}

class AppRouter {
  static const signIn = "/k";
  static const home = '/';
  static const leagues = '/leagues';
  static const addLeague = '/add-league';
  static const leagueTable = '/league-table';
  static const leagueMatches = '/league-matches';
  static const editEvent = '/editEvent';
  static const players = '/players';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: signIn,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SignInView(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return DashboardScreen(body: child);
        },
        routes: [
          GoRoute(
            path: home,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const HomeView(),
            ),
          ),
          GoRoute(
            path: leagues,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const LeaguesView(),
            ),
          ),
          GoRoute(
            path: addLeague,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const AddLeagueView(),
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
              return buildPageWithDefaultTransition<void>(
                context: context,
                state: state,
                child: EditEventView(
                  event: event,
                ),
              );
            },
          ),
          GoRoute(
            path: players,
            pageBuilder: (context, state) =>
                buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const PlayersView(),
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
