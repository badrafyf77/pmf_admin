import 'package:pmf_admin/core/config/router.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            AppRouter.navigateOff(context, AppRouter.signIn);
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
      ),
    );
  }
}
