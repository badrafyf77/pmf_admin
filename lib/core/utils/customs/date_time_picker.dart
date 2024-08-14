import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomDateAndTimePicker extends StatelessWidget {
  const CustomDateAndTimePicker({
    super.key,
    required this.height,
    required this.width,
    required this.date,
    required this.onPressed,
  });

  final double height;
  final double width;
  final DateTime date;
  final dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          CustomButton(
            onPressed: onPressed,
            title: 'Start date:',
            backgroundColor: Colors.black.withOpacity(0.6),
            height: 35,
            width: 160,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              BoardDateFormat('yyyy/MM/dd HH:mm').format(date),
              style: Styles.normal14,
            ),
          ),
        ],
      ),
    );
  }
}
