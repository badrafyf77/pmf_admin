import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class BarItem extends StatelessWidget {
  const BarItem({
    super.key,
    required this.isSelected,
    required this.value,
    required this.onTap,
  });

  final String value;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (isSelected)
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 3,
                ),
              ),
            )
          : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            value,
            style: Styles.normal16.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}