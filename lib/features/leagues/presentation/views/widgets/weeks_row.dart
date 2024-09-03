import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';

class WeeksRow extends StatefulWidget {
  const WeeksRow({
    super.key,
    required this.league,
  });

  final League league;

  @override
  State<WeeksRow> createState() => _WeeksRowState();
}

class _WeeksRowState extends State<WeeksRow> {
  late int round;

  @override
  void initState() {
    round = widget.league.currentRound;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (round > 1) {
              setState(() {
                round--;
              });
              BlocProvider.of<LeaguesCubit>(context)
                  .getMatches(widget.league, round);
            }
          },
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.kPrimaryColor,
          ),
          highlightColor: Colors.white,
        ),
        const SizedBox(width: 50),
        Text(
          "Week $round",
          style: Styles.normal20.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryColor,
          ),
        ),
        const SizedBox(width: 50),
        IconButton(
          onPressed: () {
            int maxRounds = (widget.league.totalPlayers - 1) *
                (widget.league.isHomeAndAway ? 2 : 1);
            if (round < maxRounds) {
              setState(() {
                round++;
              });
              BlocProvider.of<LeaguesCubit>(context)
                  .getMatches(widget.league, round);
            }
          },
          icon: const Icon(
            Icons.chevron_right,
            color: AppColors.kPrimaryColor,
          ),
          highlightColor: Colors.white,
        ),
      ],
    );
  }
}
