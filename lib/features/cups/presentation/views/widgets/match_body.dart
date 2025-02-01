import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/models/fixture_model.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/match_player_item.dart';

class MatchBody extends StatefulWidget {
  const MatchBody({
    super.key,
    required this.fixture,
    required this.league,
  });

  final League league;
  final Fixture fixture;

  @override
  State<MatchBody> createState() => _MatchBodyState();
}

class _MatchBodyState extends State<MatchBody> {
  TextEditingController homeController = TextEditingController();
  TextEditingController awayController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    homeController.text = widget.fixture.homeGoals.toString();
    awayController.text = widget.fixture.awayGoals.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PlayerItem(
            fixture: widget.fixture,
            homeController: homeController,
            awayController: awayController,
          ),
          const SizedBox(height: 15),
          CustomButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<LeaguesCubit>(context).editFixture(
                  widget.league,
                  widget.fixture,
                  int.parse(homeController.text),
                  int.parse(awayController.text),
                );
              }
            },
            title: 'Edit',
            backgroundColor: AppColors.kPrimaryColor,
            height: 50,
          ),
        ],
      ),
    );
  }
}
