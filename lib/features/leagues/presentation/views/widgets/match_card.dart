import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/card_item.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

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
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardItem(
                    playerName: "Afyf Badreddine",
                    goals: 3,
                    isWinner: true,
                  ),
                  CardItem(
                    playerName: "Younesse Lamtti",
                    goals: 0,
                    isWinner: false,
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
