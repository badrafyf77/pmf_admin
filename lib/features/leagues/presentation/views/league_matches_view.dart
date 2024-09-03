import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/bar.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/generate_league_matches.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_image_and_info.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_matches.dart';

class LeagueMatchesView extends StatelessWidget {
  const LeagueMatchesView({super.key, required this.league, required this.round});

  final League league;
  final int round;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            NavigateBackIcon(
              title: 'Manage league',
              onPressed: () {
                AppRouter.navigateTo(context, AppRouter.leagues);
              },
            ),
            LeagueImageAndInfo(league: league),
            league.currentRound == 0
                ? GenerateMatches(league: league)
                : Column(
                    children: [
                      LeagueBar(
                        league: league,
                        isMatchesSelected: true,
                      ),
                      LeagueMatches(
                        league: league,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
