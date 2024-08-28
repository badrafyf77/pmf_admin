import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_item.dart';
import 'package:flutter/material.dart';

class LeaguesList extends StatelessWidget {
  const LeaguesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    League l1 = League(
      id: 'kns',
      title: 'jsjjsws',
      downloadUrl: 'downloadUrl',
      startDate: Timestamp.now(),
    );
    List<League> fakeLeagueList = [l1, l1];
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: fakeLeagueList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                LeagueItem(
                  league: fakeLeagueList[index],
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
