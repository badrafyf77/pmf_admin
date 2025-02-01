import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/features/cups/presentation/views/widgets/cup_image_and_info.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';

class CupItem extends StatelessWidget {
  const CupItem({
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
                    Expanded(
                      child: CupInfo(
                        league: league,
                      ),
                    ),
                    ManageButton(
                      onPressed: () {},
                    ),
                    // const SizedBox(width: 5),
                    // EditButton(
                    //   onPressed: () {},
                    // ),
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
