import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/leagues_list.dart';
import 'package:flutter/material.dart';

class LeaguesView extends StatelessWidget {
  const LeaguesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
          const LeaguesList(),
        ],
      ),
    );
  }
}
