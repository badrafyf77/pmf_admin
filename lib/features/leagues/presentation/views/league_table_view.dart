import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/bar.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_image_and_info.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/table.dart';

class LeagueTableView extends StatelessWidget {
  const LeagueTableView({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            NavigateBackIcon(
              title: 'Manage league',
              onPressed: () {
                AppRouter.navigateTo(context, AppRouter.leagues);
              },
            ),
            LeagueImageAndInfo(league: league),
            league.currentRound == 0
                ? GenerateMatches(league: league)
                : Column(
                    children: [
                      LeagueBar(
                        league: league,
                        isTableSelected: true,
                      ),
                      StandingTable(playersList: leaguePlayers),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class GenerateMatches extends StatelessWidget {
  const GenerateMatches({
    super.key,
    required this.league,
  });

  final League league;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesFailure) {
          myShowToastError(context, state.err);
        }
        if (state is GenerateMatchesSuccess) {
          AppRouter.navigateToWithExtra(
              context, AppRouter.leagueTable, state.league);
        }
      },
      builder: (context, state) {
        if (state is Leagueslaoding) {
          return Column(
            children: [
              const SizedBox(height: 20),
              const CustomLoadingIndicator(),
              const SizedBox(height: 20),
              Text(
                "Please be patient, this may take a moment.",
                style: Styles.normal16,
              ),
            ],
          );
        }
        return SizedBox(
          height: 200,
          child: Center(
            child: CustomButton(
              onPressed: () {
                BlocProvider.of<LeaguesCubit>(context).generateMatches(league);
              },
              title: 'Generate Matches',
              backgroundColor: AppColors.kPrimaryColor,
              height: 50,
              width: 300,
            ),
          ),
        );
      },
    );
  }
}
