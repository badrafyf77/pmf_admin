import 'package:pmf_admin/core/utils/assets.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height = 100,
  });

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      height: height,
    );
  }
}
