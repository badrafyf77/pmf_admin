import 'dart:io';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/assets.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/check_box.dart';
import 'package:pmf_admin/core/utils/customs/custom_gridview_animation_config.dart';
import 'package:pmf_admin/core/utils/customs/date_time_picker.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/helpers/validators.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/add_player_item.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';
import 'package:pmf_admin/features/users/presentation/manager/get%20users%20cubit/get_users_cubit.dart';

class AddLeagueBody extends StatefulWidget {
  const AddLeagueBody({
    super.key,
  });

  @override
  State<AddLeagueBody> createState() => _AddLeagueBodyState();
}

class _AddLeagueBodyState extends State<AddLeagueBody> {
  TextEditingController titleController = TextEditingController();
  TextEditingController totalPlayersController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final ValueNotifier<String> searchQuery = ValueNotifier<String>("");

  DateTime startDate = DateTime.now();

  bool isHomeAndAway = true;

  XFile? image;

  GlobalKey<FormState> formKey = GlobalKey();

  List<UserInformation> selectedUsers = [];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    totalPlayersController.dispose();
  }

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
          return Form(
            key: formKey,
            child: Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'General Information',
                                            style: Styles.normal18,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'League title',
                                            style: Styles.normal15,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomTextField(
                                            controller: titleController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter league title';
                                              }
                                              return null;
                                            },
                                            hintText: 'Title',
                                            width: constraints.maxWidth,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Total Number of Players',
                                            style: Styles.normal15,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomTextField(
                                            controller: totalPlayersController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter total players';
                                              } else if (!isNumeric(value)) {
                                                return 'Enter a valide total players';
                                              }
                                              return null;
                                            },
                                            hintText: 'Total players',
                                            width: constraints.maxWidth,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          LeagueTypeCheckBoxs(
                                            text: 'Type',
                                            firstText: 'Home And Away',
                                            firstValue: isHomeAndAway,
                                            onTapFirst: (selected) {
                                              setState(() {
                                                isHomeAndAway = !isHomeAndAway;
                                              });
                                            },
                                            secondText: 'Home',
                                            secondValue: !isHomeAndAway,
                                            onTapSecond: (selected) {
                                              setState(() {
                                                isHomeAndAway = !isHomeAndAway;
                                              });
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Start Date',
                                            style: Styles.normal15,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomDateAndTimePicker(
                                            date: startDate,
                                            onPressed: () async {
                                              final result =
                                                  await showBoardDateTimePicker(
                                                context: context,
                                                initialDate: startDate,
                                                pickerType:
                                                    DateTimePickerType.datetime,
                                                options:
                                                    const BoardDateTimeOptions(
                                                  startDayOfWeek:
                                                      DateTime.sunday,
                                                  pickerFormat:
                                                      PickerFormat.ymd,
                                                ),
                                                onResult: (val) {},
                                              );
                                              if (result != null) {
                                                setState(
                                                    () => startDate = result);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 340,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        'League picture',
                                        style: Styles.normal18,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      image == null
                                          ? InkWell(
                                              onTap: () async {
                                                try {
                                                  final ImagePicker picker =
                                                      ImagePicker();
                                                  image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  setState(() {});
                                                  // ignore: empty_catches
                                                } catch (e) {}
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Image.file(
                                                  File(image!.path),
                                                  fit: BoxFit.fill,
                                                  height: 180,
                                                  width: 250,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      image = null;
                                                    });
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                onPressed: () {
                                  if (image == null) {
                                    myShowToastError(
                                        context, "Select an image");
                                  } else if (formKey.currentState!.validate()) {
                                    BlocProvider.of<LeaguesCubit>(context)
                                        .addLeague(
                                      titleController.text,
                                      startDate,
                                      selectedUsers,
                                      int.parse(totalPlayersController.text),
                                      isHomeAndAway,
                                      image,
                                    );
                                    setState(() {
                                      titleController.clear();
                                      totalPlayersController.clear();
                                      image = null;
                                    });
                                  }
                                },
                                title: "Add",
                                backgroundColor: AppColors.kPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add Players (${selectedUsers.length})',
                                    style: Styles.normal18,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 15),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * .58,
                                        child: Column(
                                          children: [
                                            CustomTextField(
                                              controller: searchController,
                                              onChanged: (value) {
                                                setState(() {
                                                  searchQuery.value = value;
                                                });
                                              },
                                              validator: (value) {
                                                return null;
                                              },
                                              hintText: "Search",
                                            ),
                                            const SizedBox(height: 10),
                                            ValueListenableBuilder<String>(
                                                valueListenable: searchQuery,
                                                builder:
                                                    (context, value, child) {
                                                  var filteredUsers = state
                                                      .usersList
                                                      .where((user) {
                                                    return user.displayName
                                                        .toLowerCase()
                                                        .contains(searchQuery
                                                            .value
                                                            .toLowerCase());
                                                  }).toList();
                                                  return GridView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 150.0,
                                                      mainAxisSpacing: 20.0,
                                                      crossAxisSpacing: 20.0,
                                                      childAspectRatio: 4.0,
                                                    ),
                                                    itemCount:
                                                        filteredUsers.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return CustomGridviewAnimationConfig(
                                                          index: index,
                                                          columnCount:
                                                              filteredUsers
                                                                  .length,
                                                          child: PlayerItem(
                                                            user: filteredUsers[
                                                                index],
                                                            onTap: () {
                                                              setState(() {
                                                                if (selectedUsers
                                                                    .contains(
                                                                        filteredUsers[
                                                                            index])) {
                                                                  myShowToastError(
                                                                      context,
                                                                      "Player already exist");
                                                                } else {
                                                                  selectedUsers.add(
                                                                      filteredUsers[
                                                                          index]);
                                                                }
                                                              });
                                                            },
                                                          ));
                                                    },
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                        width: constraints.maxWidth * .38,
                                        child: selectedUsers.isEmpty
                                            ? Center(
                                                child: Text(
                                                  "No player selected",
                                                  style: Styles.normal16
                                                      .copyWith(
                                                          color: Colors.grey),
                                                ),
                                              )
                                            : ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: selectedUsers.length,
                                                itemBuilder: (context, index) {
                                                  return AddPlayerItem(
                                                    selectedUsers:
                                                        selectedUsers,
                                                    index: index,
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedUsers
                                                            .removeAt(index);
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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

class PlayerItem extends StatelessWidget {
  const PlayerItem({super.key, required this.user, this.onTap});

  final UserInformation user;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                const SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    foregroundImage: AssetImage(AppAssets.logo),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        user.displayName,
                        style: Styles.normal16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Text(
                          user.email,
                          style: Styles.normal12.copyWith(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LeagueTypeCheckBoxs extends StatelessWidget {
  const LeagueTypeCheckBoxs({
    super.key,
    required this.text,
    required this.firstText,
    required this.firstValue,
    required this.secondText,
    required this.secondValue,
    required this.onTapFirst,
    required this.onTapSecond,
  });

  final String text;
  final String firstText;
  final bool firstValue;
  final String secondText;
  final bool secondValue;
  final Function(bool?) onTapFirst;
  final Function(bool?) onTapSecond;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Styles.normal14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCheckBox(
              text: firstText,
              value: firstValue,
              onTap: onTapFirst,
            ),
            const SizedBox(width: 2),
            CustomCheckBox(
              text: secondText,
              value: secondValue,
              onTap: onTapSecond,
            ),
          ],
        ),
      ],
    );
  }
}
