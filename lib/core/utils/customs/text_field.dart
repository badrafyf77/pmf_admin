import 'package:flutter/services.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.isPass = false,
    this.isTextArea = false,
    this.isMatchResult = false,
    required this.controller,
    required this.validator,
    this.hintText,
    this.width,
  });

  final bool isPass;
  final bool isTextArea;
  final bool isMatchResult;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: isTextArea ? 5 : 1,
        //for match result text field
        keyboardType: isMatchResult ? TextInputType.number : null,
        inputFormatters: isMatchResult
            ? [
                LengthLimitingTextInputFormatter(2),
              ]
            : null,
        controller: controller,
        validator: validator,
        obscureText: isPass,
        textAlign: TextAlign.center,
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
