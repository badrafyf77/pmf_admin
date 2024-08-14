import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';

class EventInfoBody extends StatelessWidget {
  const EventInfoBody({
    super.key,
    required this.event,
  });

  final League event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              event.title,
              style: Styles.normal24.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'event.description',
              style: Styles.normal16.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.place,
                  color: AppColors.kPrimaryColor,
                ),
                const SizedBox(width: 5),
                Text(
                  'event.place',
                  style: Styles.normal14.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.kPrimaryColor,
                ),
                const SizedBox(width: 5),
                Text(
                  BoardDateFormat('yyyy/MM/dd HH:mm')
                      .format(event.startDate.toDate()),
                  style: Styles.normal14.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventPicture extends StatelessWidget {
  const EventPicture({
    super.key,
    required this.downloadUrl,
  });

  final String downloadUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CustomCashedNetworkImage(
        url: downloadUrl,
        height: 300,
        width: 400,
      ),
    );
  }
}
