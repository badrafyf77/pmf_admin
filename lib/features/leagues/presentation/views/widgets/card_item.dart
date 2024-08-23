import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.playerName,
    required this.goals,
    required this.isWinner,
  });

  final String playerName;
  final int goals;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            playerName,
            style: Styles.normal18.copyWith(
              fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              color: isWinner ? Colors.white : Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          goals.toString(),
          style: Styles.normal18.copyWith(
            fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
            color: isWinner ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}
