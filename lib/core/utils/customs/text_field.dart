import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.isPass = false,
    this.isTextArea = false,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.width,
  });

  final bool isPass;
  final bool isTextArea;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: isTextArea ? 5 : 1,
        controller: controller,
        validator: validator,
        obscureText: isPass,
        style: Styles.normal16.copyWith(
          fontWeight: FontWeight.normal,
        ),
        cursorColor: AppColors.kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Styles.normal16.copyWith(
            color: Colors.grey[500],
            fontWeight: FontWeight.normal,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 10,
            height: 0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
