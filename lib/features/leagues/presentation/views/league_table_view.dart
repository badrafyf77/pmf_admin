import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/bar.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/table.dart';

class LeagueTableView extends StatelessWidget {
  const LeagueTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
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
              Text(
                "Serie 1",
                style: Styles.normal30,
              ),
              const LeagueBar(
                isTableSelected: true,
              ),
              StandingTable(playersList: leaguePlayers),
            ],
          ),
        ),
      ),
    );
  }
}
