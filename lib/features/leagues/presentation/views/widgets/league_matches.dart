import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/match_card.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/weeks_row.dart';

class LeagueMatches extends StatefulWidget {
  const LeagueMatches({super.key, required this.league});

  final League league;

  @override
  State<LeagueMatches> createState() => _LeagueMatchesState();
}

class _LeagueMatchesState extends State<LeagueMatches> {
  @override
  void initState() {
    BlocProvider.of<LeaguesCubit>(context)
        .getMatches(widget.league, widget.league.currentRound);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeeksRow(
          league: widget.league,
        ),
        const SizedBox(height: 10),
        BlocBuilder<LeaguesCubit, LeaguesState>(
          builder: (context, state) {
            if (state is LeaguesFailure) {
              return RefreshIcon(onPressed: () {
                BlocProvider.of<LeaguesCubit>(context)
                    .getMatches(widget.league, widget.league.currentRound);
              });
            }
            if (state is GetMatchesSuccess) {
              return GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      getCrossAxisCount(MediaQuery.of(context).size.width),
                  mainAxisExtent: 110.0,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 4.0,
                ),
                itemCount: state.fixtures.length,
                itemBuilder: (context, index) {
                  return FixtureCard(
                    league: widget.league,
                    fixture: state.fixtures[index],
                  );
                },
              );
            }
            return const CustomLoadingIndicator();
          },
        ),
      ],
    );
  }

  int getCrossAxisCount(double width) {
    if (width < 722) {
      return 1;
    } else if (width < 1059) {
      return 2;
    } else {
      return 3;
    }
  }
}
