import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/date_time_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/cubit/leagues_cubit.dart';

class EditLeagueBody extends StatefulWidget {
  const EditLeagueBody({super.key, required this.league});

  final League league;

  @override
  State<EditLeagueBody> createState() => _EditLeagueBodyState();
}

class _EditLeagueBodyState extends State<EditLeagueBody> {
  TextEditingController titleController = TextEditingController();

  late DateTime startDate;

  XFile? image;

  bool isOldImage = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.league.title;
    startDate = widget.league.startDate.toDate();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'League picture',
                                  style: Styles.normal18,
                                ),
                                if (!isOldImage)
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isOldImage = true;
                                      });
                                    },
                                    icon: const Icon(Icons.rotate_left),
                                    tooltip: 'Retour à l\'ancienne Image',
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            (isOldImage)
                                ? Column(
                                    children: [
                                      CustomCashedNetworkImage(
                                        url: widget.league.downloadUrl,
                                        height: 180,
                                        width: 250,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isOldImage = false;
                                          });
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                : image == null
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
                                          ),
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
                        if (image == null && !isOldImage) {
                          myShowToastError(context, "Select an image");
                        } else if (formKey.currentState!.validate()) {
                          BlocProvider.of<LeaguesCubit>(context).updateLeague(
                            widget.league,
                            titleController.text,
                            startDate,
                            isOldImage,
                            image,
                          );
                          setState(() {
                            titleController.clear();
                            image = null;
                          });
                        }
                      },
                      title: "Edit",
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
