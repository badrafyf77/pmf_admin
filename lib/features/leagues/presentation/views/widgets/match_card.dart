import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/card_item.dart';

class FixtureCard extends StatelessWidget {
  const FixtureCard({super.key, required this.fixture});

  final Fixture fixture;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 80,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardItem(
                    playerName: fixture.homeName,
                    goals: fixture.homeGoals,
                    isWinner: fixture.homeGoals > fixture.awayGoals,
                    isDraw: fixture.homeGoals == fixture.awayGoals,
                  ),
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
        ),
      );
    });
  }
}
