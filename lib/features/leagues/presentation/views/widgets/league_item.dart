import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_image_and_info.dart';

class LeagueItem extends StatelessWidget {
  const LeagueItem({
    super.key,
    required this.league,
  });

  final League league;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 242,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomCashedNetworkImage(
                  url: league.downloadUrl,
                  width: constraints.maxWidth * .35,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: constraints.maxWidth * .57,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: LeagueInfo(league: league)),
                    ManageButton(
                      onPressed: () {
                        AppRouter.navigateToWithExtra(
                            context, AppRouter.leagueTable, league);
                      },
                    ),
                    const SizedBox(width: 5),
                    EditButton(
                      onPressed: () {
                        AppRouter.navigateToWithExtra(
                            context, AppRouter.editLeague, league);
                      },
                    ),
                    const SizedBox(width: 5),
                    DeleteButton(
                      onPressed: () {
                        // BlocProvider.of<DeleteEventBloc>(context)
                        // .add(DeleteEvent(event: event));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
