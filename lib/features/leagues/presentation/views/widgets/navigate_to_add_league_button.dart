import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/animated_container.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:flutter/material.dart';

class NavigateToAddLeague extends StatelessWidget {
  const NavigateToAddLeague({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedContainer(
      child: CustomButton(
        onPressed: () {
          AppRouter.navigateTo(context, AppRouter.addLeague);
        },
        title: 'Add League',
        backgroundColor: AppColors.kPrimaryColor,
      ),
    );
  }
}
