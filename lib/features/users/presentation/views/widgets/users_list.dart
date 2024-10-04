import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/customs/text_field.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/users/presentation/manager/get%20users%20cubit/get_users_cubit.dart';
import 'package:pmf_admin/features/users/presentation/views/widgets/users_list_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> searchQuery = ValueNotifier<String>("");
    return BlocConsumer<GetUsersCubit, GetUsersState>(
      listener: (context, state) {
        if (state is GetUsersFailure) {
          myShowToastError(context, state.err);
        }
      },
      builder: (context, state) {
        if (state is GetUsersSuccess) {
          return ValueListenableBuilder<String>(
              valueListenable: searchQuery,
              builder: (context, value, child) {
                var filteredUsers = state.usersList.where((user) {
                  return user.displayName
                      .toLowerCase()
                      .contains(searchQuery.value.toLowerCase());
                }).toList();
                return Expanded(
                  child: Column(
                    children: [
                      CustomTextField(
                        onChanged: (value) {
                          searchQuery.value = value;
                        },
                        validator: (value) {
                          return null;
                        },
                        hintText: "Search",
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: ListView.builder(
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  UserItem(
                                    userInformation: filteredUsers[index],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
        return const Center(child: CustomLoadingIndicator());
      },
    );
  }
}
