import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/edit_league_body.dart';
import 'package:flutter/material.dart';

class EditLeagueView extends StatelessWidget {
  const EditLeagueView({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: NavigateBackIcon(
                onPressed: () {
                  AppRouter.navigateTo(context, AppRouter.leagues);
                },
                title: 'Edit League'),
          ),
          EditLeagueBody(
            event: league,
          ),
        ],
      ),
    );
  }
}
