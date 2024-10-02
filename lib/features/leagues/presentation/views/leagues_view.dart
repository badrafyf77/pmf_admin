import 'package:pmf_admin/features/leagues/presentation/views/widgets/leagues_list.dart';
import 'package:flutter/material.dart';

class LeaguesView extends StatelessWidget {
  const LeaguesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: LeaguesList(),
    );
  }
}
