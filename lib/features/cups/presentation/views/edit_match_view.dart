import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/match_body.dart';

class EditMatchView extends StatelessWidget {
  const EditMatchView({super.key, required this.fixture, required this.league});

  final League league;
  final Fixture fixture;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesFailure) {
          myShowToastError(context, state.err);
        }
        if (state is EditMatchSuccess) {
          myShowToastSuccess(context, "Match edited");
          AppRouter.navigateToWithExtra(
            context,
            AppRouter.leagueMatches,
            {
              'league': state.data['league'],
              'round': state.data['round'],
            },
          );
        }
      },
      builder: (context, state) {
        if (state is Leagueslaoding) {
          return const Center(
            child: CustomLoadingIndicator(withText: true),
          );
        }
        return Column(
          children: [
            NavigateBackIcon(
              title: '',
              onPressed: () {
                AppRouter.navigateToWithExtra(
                  context,
                  AppRouter.leagueMatches,
                  {'league': league, 'round': fixture.round},
                );
              },
            ),
            MatchBody(
              league: league,
              fixture: fixture,
            ),
          ],
        );
      },
    );
  }
}
