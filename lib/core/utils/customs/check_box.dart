import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    this.height = 40,
    this.width,
    required this.text,
    required this.onTap,
    required this.value,
  });

  final double? height;
  final double? width;
  final String text;
  final Function(bool?) onTap;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Checkbox(
            value: value,
            onChanged: onTap,
            shape: const CircleBorder(),
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            checkColor: Theme.of(context).colorScheme.primary,
          ),
          Text(
            text,
            style: Styles.normal12.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
