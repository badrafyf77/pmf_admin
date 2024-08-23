import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:flutter/material.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Text(
                          "Serie 1",
                          style: Styles.normal30,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' current fixture: 2',
                                style: Styles.normal14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '20 players',
                                      style: Styles.normal12,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    BoardDateFormat('HH:mm a')
                                        .format(league.startDate.toDate()),
                                    style: Styles.normal12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ManageButton(
                          onPressed: () {
                            AppRouter.navigateTo(
                                context, AppRouter.leagueTable);
                          },
                        ),
                        EditButton(
                          onPressed: () {},
                        ),
                        DeleteButton(
                          onPressed: () {
                            // BlocProvider.of<DeleteEventBloc>(context)
                            // .add(DeleteEvent(event: event));
                          },
                        ),
                      ],
                    )
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
