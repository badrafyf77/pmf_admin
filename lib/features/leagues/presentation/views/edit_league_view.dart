import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/edit_event_body.dart';
import 'package:flutter/material.dart';

class EditEventView extends StatelessWidget {
  const EditEventView({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          EditLeagueBody(
            event: league,
          ),
        ],
      ),
    );
  }
}
