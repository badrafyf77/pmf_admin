import 'dart:io';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/date_time_picker.dart';
import 'package:pmf_admin/core/utils/customs/drop_down_field.dart';
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
import 'package:pmf_admin/features/users/data/models/users_model.dart';
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

  DateTime startDate = DateTime.now();

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
    return Form(
      key: formKey,
      child: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Row(
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
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                MyTextField(
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
                                MyTextField(
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
                                      pickerType: DateTimePickerType.datetime,
                                      options: const BoardDateTimeOptions(
                                        startDayOfWeek: DateTime.sunday,
                                        pickerFormat: PickerFormat.ymd,
                                      ),
                                      onResult: (val) {},
                                    );
                                    if (result != null) {
                                      setState(() => startDate = result);
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
                      BlocBuilder<GetUsersCubit, GetUsersState>(
                        builder: (context, state) {
                          if (state is GetUsersFailure) {
                            return IconButton(
                              onPressed: () {
                                BlocProvider.of<GetUsersCubit>(context)
                                    .getUsers();
                              },
                              icon: const Icon(Icons.refresh),
                            );
                          }
                          if (state is GetUsersSuccess) {
                            List<String> items = [];
                            for (var element in state.usersList) {
                              items.add(element.displayName);
                            }
                            return Container(
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
                                        SizedBox(
                                          width: 200,
                                          child: MyDropDownField(
                                            onChanged: (user) {
                                              if (user != null) {
                                                int index = items.indexOf(user);
                                                setState(() {
                                                  if (selectedUsers.contains(
                                                      state.usersList[index])) {
                                                    myShowToastError(context,
                                                        "Player already exist");
                                                  } else {
                                                    selectedUsers.add(
                                                        state.usersList[index]);
                                                  }
                                                });
                                              }
                                            },
                                            items: items,
                                            initialValue: items[0],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      height: 2,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 15),
                                    selectedUsers.isEmpty
                                        ? Text(
                                            "No player selected",
                                            style: Styles.normal16
                                                .copyWith(color: Colors.grey),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: selectedUsers.length,
                                            itemBuilder: (context, index) {
                                              return AddPlayerItem(
                                                selectedUsers: selectedUsers,
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
                                  ],
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CustomLoadingIndicator(),
                          );
                        },
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
                                        image = await picker.pickImage(
                                            source: ImageSource.gallery);
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
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LeaguesCubit>(context).addLeague(
                            titleController.text,
                            startDate,
                            selectedUsers,
                            int.parse(totalPlayersController.text),
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
          ),
        ),
      ),
    );
  }
}