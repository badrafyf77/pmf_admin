import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_item.dart';
import 'package:flutter/material.dart';

class LeaguesList extends StatefulWidget {
  const LeaguesList({
    super.key,
  });

  @override
  State<LeaguesList> createState() => _LeaguesListState();
}

class _LeaguesListState extends State<LeaguesList> {
  @override
  void initState() {
    BlocProvider.of<LeaguesCubit>(context).getLeagues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaguesCubit, LeaguesState>(
      builder: (context, state) {
        if (state is LeaguesFailure) {
          return RefreshIcon(
            onPressed: () {
              BlocProvider.of<LeaguesCubit>(context).getLeagues();
            },
          );
        }
        if (state is GetLeaguesSuccess) {
          return Expanded(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: state.leaguesList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      LeagueItem(
                        league: state.leaguesList[index],
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
        return const CustomLoadingIndicator();
      },
    );
  }
}
