import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/cup_bar.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/cup_image_and_info.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/league_table.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';

class CupTablesView extends StatelessWidget {
  const CupTablesView({super.key, required this.league});

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
          CupImageAndInfo(league: league),
          Column(
            children: [
              CupBar(
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
