import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/bar.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/generate_league_matches.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_image_and_info.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_table.dart';

class LeagueTableView extends StatelessWidget {
  const LeagueTableView({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      isTableSelected: true,
                    ),
                    LeagueTable(
                      league: league,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
