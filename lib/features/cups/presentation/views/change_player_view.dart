import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/app_logo.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/custom_gridview_animation_config.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/models/player_model.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/add_league_body.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';
import 'package:pmf_admin/features/users/presentation/manager/get%20users%20cubit/get_users_cubit.dart';

class ChangePlayerView extends StatelessWidget {
  const ChangePlayerView(
      {super.key, required this.player, required this.league});

  final League league;
  final Player player;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaguesCubit, LeaguesState>(
      listener: (context, state) {
        if (state is LeaguesFailure) {
          myShowToastError(context, state.err);
        }
        if (state is LeaguesSuccess) {
          myShowToastSuccess(context, "Player changed successfully!");
          AppRouter.navigateToWithExtra(context, AppRouter.leagueTable, league);
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
                    context, AppRouter.leagueTable, league);
              },
            ),
            ChangePlayerBody(
              player: player,
              league: league,
            )
          ],
        );
      },
    );
  }
}

class ChangePlayerBody extends StatefulWidget {
  const ChangePlayerBody({
    super.key,
    required this.player,
    required this.league,
  });

  final League league;
  final Player player;

  @override
  State<ChangePlayerBody> createState() => _ChangePlayerBodyState();
}

class _ChangePlayerBodyState extends State<ChangePlayerBody> {
  TextEditingController searchController = TextEditingController();

  final ValueNotifier<String> searchQuery = ValueNotifier<String>("");

  UserInformation? selectedUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUsersCubit, GetUsersState>(
      builder: (context, state) {
        if (state is GetUsersFailure) {
          return IconButton(
            onPressed: () {
              BlocProvider.of<GetUsersCubit>(context).getUsers();
            },
            icon: const Icon(Icons.refresh),
          );
        }
        if (state is GetUsersSuccess) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const AppLogo(height: 160),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * .27,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.player.displayName,
                                      style: Styles.normal16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        CustomButton(
                          onPressed: () async {
                            if (selectedUser == null) {
                              myShowToastError(context, "Select a user");
                            } else {
                              BlocProvider.of<LeaguesCubit>(context)
                                  .changePlayer(widget.league, selectedUser!,
                                      widget.player);
                            }
                          },
                          title: 'Change',
                          backgroundColor: AppColors.kPrimaryColor,
                          height: 50,
                        ),
                        const SizedBox(width: 4),
                        Column(
                          children: [
                            const AppLogo(height: 160),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * .27,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      selectedUser != null
                                          ? selectedUser!.displayName
                                          : "select a user",
                                      style: Styles.normal16.copyWith(
                                        color: selectedUser != null
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        CustomTextField(
                          controller: searchController,
                          onChanged: (value) {
                            searchQuery.value = value;
                          },
                          validator: (value) {
                            return null;
                          },
                          hintText: "Search",
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<String>(
                            valueListenable: searchQuery,
                            builder: (context, value, child) {
                              var filteredUsers = state.usersList.where((user) {
                                return user.displayName
                                    .toLowerCase()
                                    .contains(searchQuery.value.toLowerCase());
                              }).toList();
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: 150.0,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                  childAspectRatio: 4.0,
                                ),
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  return CustomGridviewAnimationConfig(
                                      index: index,
                                      columnCount: filteredUsers.length,
                                      child: PlayerItem(
                                        user: filteredUsers[index],
                                        onTap: () {
                                          setState(() {
                                            selectedUser = filteredUsers[index];
                                          });
                                        },
                                      ));
                                },
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const CustomLoadingIndicator();
      },
    );
  }
}
