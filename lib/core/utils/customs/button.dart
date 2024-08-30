import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.fontSize = 14, this.height, this.width,
  });

  final Function()? onPressed;
  final String title;
  final Color backgroundColor;
  final double? height;
  final double? width;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Center(
            child: Text(
              title,
              style: Styles.normal14.copyWith(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
