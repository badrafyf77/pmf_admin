import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/dashboard_screen.dart';
import 'package:pmf_admin/features/auth/presentation/views/sign_in_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/add_league_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/edit_event_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/event_info_view.dart';
import 'package:pmf_admin/features/leagues/presentation/views/leagues_view.dart';
import 'package:pmf_admin/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  static const addLeague = '/addLeague';
  static const eventInfo = '/eventInfo';
  static const editEvent = '/editEvent';

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
              path: eventInfo,
              pageBuilder: (context, state) {
                League event = state.extra as League;
                return buildPageWithDefaultTransition<void>(
                  context: context,
                  state: state,
                  child: EventInfoView(
                    event: event,
                  ),
                );
              }),
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
