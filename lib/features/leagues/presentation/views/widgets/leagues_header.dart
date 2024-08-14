import 'package:pmf_admin/features/leagues/presentation/views/widgets/navigate_to_add_league_button.dart';
import 'package:pmf_admin/core/utils/customs/refresh_icon.dart';
import 'package:flutter/material.dart';

class LeaguesHeader extends StatelessWidget {
  const LeaguesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const NavigateToAddLeague(),
            RefreshIcon(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
