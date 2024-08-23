import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/add_league_body.dart';
import 'package:flutter/material.dart';

class AddLeagueView extends StatelessWidget {
  const AddLeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigateBackIcon(
            title: 'Add league',
            onPressed: () {
              AppRouter.navigateTo(context, AppRouter.leagues);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          const AddLeagueBody(),
        ],
      ),
    );
  }
}
