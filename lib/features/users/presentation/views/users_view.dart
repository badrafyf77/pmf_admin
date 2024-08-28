import 'package:pmf_admin/core/utils/customs/header.dart';
import 'package:flutter/material.dart';
import 'package:pmf_admin/features/users/presentation/views/widgets/users_list.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Header(
            buttonTitle: "Add player",
            onPressedButton: () {},
            onPressedRefresh: () {},
          ),
          const UsersList(),
        ],
      ),
    );
  }
}
