import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginJsonAnimation extends StatelessWidget {
  const LoginJsonAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.kPrimaryColor,
        child: Lottie.asset(AppAssets.login),
      ),
    );
  }
}
