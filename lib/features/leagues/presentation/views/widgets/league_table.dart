import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/table.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LeagueTable extends StatefulWidget {
  const LeagueTable({
    super.key,
    required this.league,
  });

  final League league;

  @override
  State<LeagueTable> createState() => _LeagueTableState();
}

class _LeagueTableState extends State<LeagueTable> {
  @override
  void initState() {
    BlocProvider.of<LeaguesCubit>(context).getPlayers(widget.league);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesFailure) {
          myShowToastError(context, state.err);
        }
      },
      builder: (context, state) {
        if (state is GetPlayersSuccess) {
          return StandingTable(playersList: state.playersList);
        }
        return Skeletonizer(
          enabled: true,
          child: StandingTable(playersList: leaguePlayers),
        );
      },
    );
  }
}
