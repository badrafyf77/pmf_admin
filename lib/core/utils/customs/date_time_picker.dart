import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomDateAndTimePicker extends StatelessWidget {
  const CustomDateAndTimePicker({
    super.key,
    required this.date,
    required this.onPressed,
  });

  final DateTime date;
  final dynamic Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[700],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.access_alarm,
              color: Colors.white,
            ),
            tooltip: 'Choose time',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            BoardDateFormat('yyyy/MM/dd HH:mm').format(date),
            style: Styles.normal14,
          ),
        ),
      ],
    );
  }
}
