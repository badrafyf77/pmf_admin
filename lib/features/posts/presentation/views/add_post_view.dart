import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmf_admin/core/config/router.dart';
import 'package:pmf_admin/core/utils/colors.dart';
import 'package:pmf_admin/core/utils/customs/button.dart';
import 'package:pmf_admin/core/utils/customs/navigate_back_iconbutton.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/core/utils/styles.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavigateBackIcon(
          title: 'Add Post',
          onPressed: () {
            AppRouter.navigateTo(context, AppRouter.posts);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: AddPostBody(),
        ),
      ],
    );
  }
}

class AddPostBody extends StatefulWidget {
  const AddPostBody({
    super.key,
  });

  @override
  State<AddPostBody> createState() => _AddPostBodyState();
}

class _AddPostBodyState extends State<AddPostBody> {
  TextEditingController descriptionController = TextEditingController();

  XFile? image;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
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
                                  'Post description',
                                  style: Styles.normal15,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  isTextArea: true,
                                  controller: descriptionController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter post description';
                                    }
                                    return null;
                                  },
                                  hintText: 'Description',
                                  width: constraints.maxWidth,
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
                              'Post picture',
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
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (image == null) {
                          myShowToastError(context, "Select an image");
                        } else if (formKey.currentState!.validate()) {
                          // BlocProvider.of<LeaguesCubit>(context)
                          //     .addLeague(
                          //   titleController.text,
                          //   startDate,
                          //   selectedUsers,
                          //   int.parse(totalPlayersController.text),
                          //   isHomeAndAway,
                          //   image,
                          // );
                          setState(() {
                            descriptionController.clear();
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
