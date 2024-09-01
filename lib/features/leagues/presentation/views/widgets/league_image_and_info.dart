import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';

class LeagueImageAndInfo extends StatelessWidget {
  const LeagueImageAndInfo({
    super.key,
    required this.league,
  });

  final League league;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CustomCashedNetworkImage(
            url: league.downloadUrl,
            width: 180,
            height: 200,
          ),
        ),
        Expanded(
          child: LeagueInfo(
            league: league,
          ),
        ),
      ],
    );
  }
}

class LeagueInfo extends StatelessWidget {
  const LeagueInfo({
    super.key,
    required this.league,
  });

  final League league;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          league.title,
          style: Styles.normal30,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' current round: ${league.currentRound}',
              style: Styles.normal14,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    '${league.totalPlayers} players',
                    style: Styles.normal12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  BoardDateFormat('dd/MM/yyyy HH:mm a')
                      .format(league.startDate.toDate()),
                  style: Styles.normal12,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}