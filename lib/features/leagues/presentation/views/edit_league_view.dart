import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/edit_league_body.dart';
import 'package:flutter/material.dart';

class EditLeagueView extends StatelessWidget {
  const EditLeagueView({super.key, required this.league});

  final League league;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesFailure) {
          myShowToastError(context, state.err);
        }
        if (state is LeaguesSuccess) {
          myShowToastSuccess(context, "League edited successfully!");
          AppRouter.navigateTo(context, AppRouter.leagues);
        }
      },
      builder: (context, state) {
        if (state is Leagueslaoding) {
          return const Center(child: CustomLoadingIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: NavigateBackIcon(
                    onPressed: () {
                      AppRouter.navigateTo(context, AppRouter.leagues);
                    },
                    title: 'Edit League'),
              ),
              EditLeagueBody(
                league: league,
              ),
            ],
          ),
        );
      },
    );
  }
}
