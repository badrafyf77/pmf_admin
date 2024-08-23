import 'package:flutter/material.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/match_card.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/weeks_row.dart';

class LeagueMatches extends StatelessWidget {
  const LeagueMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WeeksRow(),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                getCrossAxisCount(MediaQuery.of(context).size.width),
            mainAxisExtent: 80.0,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 4.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const MatchCard();
          },
        ),
      ],
    );
  }

  int getCrossAxisCount(double width) {
    if (width < 722) {
      return 1;
    } else if (width < 1059) {
      return 2;
    } else {
      return 3;
    }
  }
}
