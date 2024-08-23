import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/animated_container.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/manage_buttons.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class PlayerItem extends StatelessWidget {
  const PlayerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 120,
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
                  url: "player.displayName",
                  width: constraints.maxWidth * .12,
                  height: 100,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: constraints.maxWidth * .8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Afyf Badreddine",
                        style: Styles.normal24,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomAnimatedContainer(
                          child: CustomButton(
                            onPressed: () {
                              // AppRouter.navigateToWithExtra(
                              //     context, AppRouter.eventInfo, 'league');
                            },
                            title: 'Voir Plus',
                            backgroundColor: AppColors.kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        EditButton(
                          onPressed: () {},
                        ),
                        const SizedBox(width: 15),
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