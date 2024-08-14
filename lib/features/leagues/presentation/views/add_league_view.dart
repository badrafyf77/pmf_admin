import 'package:pmf_admin/features/leagues/presentation/views/widgets/add_league_body.dart';
import 'package:flutter/material.dart';

class AddLeagueView extends StatelessWidget {
  const AddLeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NavigateBackIcon(
          //   title: 'Ajouter un événement',
          //   onPressed: () {
          //     AppRouter.navigateTo(context, AppRouter.events);
          //   },
          // ),
          SizedBox(
            height: 20,
          ),
          AddLeagueBody(),
        ],
      ),
    );
  }
}
