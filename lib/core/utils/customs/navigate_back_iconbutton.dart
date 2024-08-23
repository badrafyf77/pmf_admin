import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class NavigateBackIcon extends StatelessWidget {
  const NavigateBackIcon({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
          ),
          Text(
            title,
            style: Styles.normal20,
          ),
        ],
      ),
    );
  }
}
