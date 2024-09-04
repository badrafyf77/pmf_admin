import 'package:flutter/material.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/card_item.dart';

class FixtureCard extends StatelessWidget {
  const FixtureCard({super.key, required this.fixture, required this.league});

  final Fixture fixture;
  final League league;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: InkWell(
        onTap: () {
          AppRouter.navigateToWithExtra(
            context,
            AppRouter.match,
            {'league': league, 'fixture': fixture},
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!fixture.isPlayed)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Not played yet",
                  style: Styles.normal14,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardItem(
                      playerName: fixture.homeName,
                      goals: fixture.homeGoals,
                      isWinner: fixture.homeGoals > fixture.awayGoals,
                      isDraw: fixture.homeGoals == fixture.awayGoals,
                    ),
                    const SizedBox(height: 5),
                    CardItem(
                      playerName: fixture.awayName,
                      goals: fixture.awayGoals,
                      isWinner: fixture.awayGoals > fixture.homeGoals,
                      isDraw: fixture.awayGoals == fixture.homeGoals,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
