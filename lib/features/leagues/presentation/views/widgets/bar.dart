import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/bar_item.dart';

class LeagueBar extends StatelessWidget {
  const LeagueBar(
      {super.key,
      this.isTableSelected = false,
      this.isMatchesSelected = false,
      required this.league});

  final League league;
  final bool isTableSelected;
  final bool isMatchesSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          BarItem(
            value: "Table",
            onTap: () {
              AppRouter.navigateToWithExtra(
                  context, AppRouter.leagueTable, league);
            },
            isSelected: isTableSelected,
          ),
          BarItem(
            value: "Matches",
            onTap: () {
              AppRouter.navigateToWithExtra(
                  context, AppRouter.leagueMatches, league);
            },
            isSelected: isMatchesSelected,
          ),
        ],
      ),
    );
  }
}
