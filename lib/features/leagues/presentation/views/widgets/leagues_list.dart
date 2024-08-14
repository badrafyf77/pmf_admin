import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/leagues_listview_builder.dart';
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
      players: [],
    );
    List<League> fakeLeagueList = [l1, l1];
    return Expanded(
      child: LeaguesListViewBuilder(
        itemsList: fakeLeagueList,
      ),
    );
  }
}
