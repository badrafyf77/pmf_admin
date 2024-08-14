import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/helpers/month_names.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class EventCercleTime extends StatelessWidget {
  const EventCercleTime({
    super.key,
    required this.date,
  });

  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.toDate().day.toString(),
              style: Styles.normal15.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              getMonthName(date.toDate()),
              style: Styles.normal12.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
