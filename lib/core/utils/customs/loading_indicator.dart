import 'package:pmf_admin/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.color = AppColors.kPrimaryColor,
    this.height = 80,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        child: const LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [AppColors.kPrimaryColor],
          strokeWidth: 3,
        ),
      ),
    );
  }
}
