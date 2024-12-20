import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/styles.dart';
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
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesSuccess) {
          BlocProvider.of<LeaguesCubit>(context).getLeagues();
          myShowToastSuccess(context, "League deleted successfully!");
        }
      },
      builder: (context, state) {
        if (state is LeaguesFailure) {
          return RefreshIcon(
            onPressed: () {
              BlocProvider.of<LeaguesCubit>(context).getLeagues();
            },
          );
        }
        if (state is GetLeaguesSuccess) {
          return Column(
            children: [
              Header(
                buttonTitle: "Add league",
                onPressedButton: () {
                  AppRouter.navigateTo(context, AppRouter.addLeague);
                },
                onPressedRefresh: () {
                  BlocProvider.of<LeaguesCubit>(context).getLeagues();
                },
              ),
              state.leaguesList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "No leagues to show",
                          style: Styles.normal16.copyWith(color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
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
            ],
          );
        }
        return const CustomLoadingIndicator();
      },
    );
  }
}
