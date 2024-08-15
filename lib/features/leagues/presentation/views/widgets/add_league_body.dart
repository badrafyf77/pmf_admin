import 'dart:io';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/date_time_picker.dart';
import 'package:pmf_admin/core/utils/customs/drop_down_field.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/add%20event%20bloc/add_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddLeagueBody extends StatefulWidget {
  const AddLeagueBody({
    super.key,
  });

  @override
  State<AddLeagueBody> createState() => _AddLeagueBodyState();
}

class _AddLeagueBodyState extends State<AddLeagueBody> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  DateTime date = DateTime.now();

  XFile? image;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    placeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> fakePlayers = [
      'Afyf Badreddine',
      'Yassine Chafik',
      'Younesse Lamtti',
    ];
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
                                  'Start Date',
                                  style: Styles.normal15,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomDateAndTimePicker(
                                  date: date,
                                  onPressed: () async {
                                    final result =
                                        await showBoardDateTimePicker(
                                      context: context,
                                      initialDate: date,
                                      pickerType: DateTimePickerType.datetime,
                                      options: const BoardDateTimeOptions(
                                        startDayOfWeek: DateTime.sunday,
                                        pickerFormat: PickerFormat.ymd,
                                      ),
                                      onResult: (val) {},
                                    );
                                    if (result != null) {
                                      setState(() => date = result);
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
                      if (fakePlayers.isNotEmpty)
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
                                      'Add Players',
                                      style: Styles.normal18,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: MyDropDownField(
                                        onChanged: (onChanged) {},
                                        items: fakePlayers,
                                        initialValue: fakePlayers[0],
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: fakePlayers.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Text('${(index + 1)}-'),
                                        const SizedBox(width: 5),
                                        Text(
                                          fakePlayers[index],
                                          style: Styles.normal16,
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
                          BlocProvider.of<AddEventBloc>(context).add(
                            AddEvent(
                              title: titleController.text,
                              description: descriptionController.text,
                              place: placeController.text,
                              date: date,
                              image: image,
                            ),
                          );
                          setState(() {
                            titleController.clear();
                            descriptionController.clear();
                            placeController.clear();
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
