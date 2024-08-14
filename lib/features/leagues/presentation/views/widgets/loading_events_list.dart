import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomEventsListLoading extends StatelessWidget {
  const CustomEventsListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    League e1 = League(
      id: 'kns',
      title: 'jsjjsws',
      downloadUrl: 'downloadUrl',
      startDate: Timestamp.now(),
      players: [],
    );
    List<League> fakeEventsList = [e1, e1];
    return Skeletonizer(
      enabled: true,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: fakeEventsList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                LeagueItem(
                  league: fakeEventsList[index],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
