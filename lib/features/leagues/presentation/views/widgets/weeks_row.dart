import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class WeeksRow extends StatelessWidget {
  const WeeksRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.kPrimaryColor,
          ),
          highlightColor: Colors.white,
        ),
        const SizedBox(width: 50),
        Text(
          "Week 2",
          style: Styles.normal20.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryColor,
          ),
        ),
        const SizedBox(width: 50),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_right,
            color: AppColors.kPrimaryColor,
          ),
          highlightColor: Colors.white,
        ),
      ],
    );
  }
}
