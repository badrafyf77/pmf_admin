import 'package:pmf_admin/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.withText = false,
    this.color = AppColors.kPrimaryColor,
    this.height = 80,
  });

  final bool withText;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: height,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [AppColors.kPrimaryColor],
                strokeWidth: 3,
              ),
            ),
          ),
          if (withText)
            Text(
              "Please be patient, this may take a moment.",
              style: Styles.normal14,
            ),
        ],
      ),
    );
  }
}
