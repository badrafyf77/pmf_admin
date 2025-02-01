import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/cup_item.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';

class CupsList extends StatelessWidget {
  const CupsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    League fakeLeague = League(
      id: "id",
      title: "title",
      downloadUrl: "downloadUrl",
      startDate: Timestamp.now(),
      totalPlayers: 2,
      currentRound: 2,
      isHomeAndAway: true,
    );
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CupItem(
                    league: fakeLeague,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
