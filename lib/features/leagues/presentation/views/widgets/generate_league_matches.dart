import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';

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