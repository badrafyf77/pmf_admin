import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/edit%20event%20bloc/edit_event_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/cashed_network_image.dart';
import 'package:pmf_admin/core/utils/customs/date_time_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditEventBody extends StatefulWidget {
  const EditEventBody({super.key, required this.event});

  final League event;

  @override
  State<EditEventBody> createState() => _EditEventBodyState();
}

class _EditEventBodyState extends State<EditEventBody> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  late DateTime date;

  XFile? image;

  bool oldImage = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.title;
    date = widget.event.startDate.toDate();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    placeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 520,
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
                        'Informations Générales',
                        style: Styles.normal18,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Titre de l\'événement',
                        style: Styles.normal15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrer le titre';
                          }
                          return null;
                        },
                        hintText: 'Titre',
                        width: constraints.maxWidth,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description de l\'événement',
                        style: Styles.normal15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        isTextArea: true,
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrer la description';
                          }
                          return null;
                        },
                        hintText: 'Description',
                        width: constraints.maxWidth,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Lieu de l\'événement',
                        style: Styles.normal15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MyTextField(
                        controller: placeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrer le lieu';
                          }
                          return null;
                        },
                        hintText: 'Lieu',
                        width: constraints.maxWidth,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDateAndTimePicker(
                        height: 30,
                        width: constraints.maxWidth,
                        date: date,
                        onPressed: () async {
                          final result = await showBoardDateTimePicker(
                            context: context,
                            initialDate: date,
                            pickerType: DateTimePickerType.datetime,
                            options: const BoardDateTimeOptions(
                              languages: BoardPickerLanguages(
                                locale: 'fr',
                                today: 'Aujourd’hui',
                                tomorrow: 'Demain',
                                now: 'Maintenant',
                              ),
                              startDayOfWeek: DateTime.sunday,
                              pickerFormat: PickerFormat.ymd,
                              pickerSubTitles: BoardDateTimeItemTitles(
                                year: 'Année',
                                month: 'Mois',
                                day: 'Jour',
                                hour: 'Heure',
                              ),
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
                            'Image de l\'événement',
                            style: Styles.normal18,
                          ),
                          if (!oldImage)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  oldImage = true;
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
                      (oldImage)
                          ? Column(
                              children: [
                                CustomCashedNetworkImage(
                                  url: widget.event.downloadUrl,
                                  height: 180,
                                  width: 250,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      oldImage = false;
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
                                      final ImagePicker picker = ImagePicker();
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
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<EditEventBloc>(context).add(
                      EditEvent(
                        id: widget.event.id,
                        title: titleController.text,
                        oldTitle: widget.event.title,
                        description: descriptionController.text,
                        place: placeController.text,
                        oldImage: oldImage,
                        downloadUrl: widget.event.downloadUrl,
                        image: image,
                        date: date,
                      ),
                    );
                  }
                },
                title: "Editer",
                backgroundColor: AppColors.kPrimaryColor,
                height: 35,
                width: 130,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
