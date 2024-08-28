import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/core/utils/customs/loading_indicator.dart';
import 'package:pmf_admin/core/utils/helpers/show_toast.dart';
import 'package:pmf_admin/features/users/presentation/manager/get%20users%20cubit/get_users_cubit.dart';
import 'package:pmf_admin/features/users/presentation/views/widgets/users_list_item.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUsersCubit, GetUsersState>(
      listener: (context, state) {
        if (state is GetUsersFailure) {
          myShowToastError(context, state.err);
        }
      },
      builder: (context, state) {
        if (state is GetUsersSuccess) {
          return Expanded(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: state.usersList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      UserItem(
                        userInformation: state.usersList[index],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return const Center(child: CustomLoadingIndicator());
      },
    );
  }
}
