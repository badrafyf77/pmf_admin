import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/add_league_body.dart';
import 'package:flutter/material.dart';

class AddLeagueView extends StatelessWidget {
  const AddLeagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigateBackIcon(
            title: 'Add league',
            onPressed: () {
              AppRouter.navigateTo(context, AppRouter.leagues);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<LeaguesCubit, LeaguesState>(
            listener: (context, state) {
              if (state is LeaguesFailure) {
                myShowToastError(context, state.err);
              }
              if (state is LeaguesSuccess) {
                myShowToastSuccess(context, "League added successfully!");
                AppRouter.navigateTo(context, AppRouter.leagues);
              }
            },
            builder: (context, state) {
              if (state is Leagueslaoding) {
                return const Center(
                  child: CustomLoadingIndicator(withText: true),
                );
              }
              return const AddLeagueBody();
            },
          ),
        ],
      ),
    );
  }
}
