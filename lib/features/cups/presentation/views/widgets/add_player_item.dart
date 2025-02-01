import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/users/data/models/user_info_model.dart';

class AddPlayerItem extends StatelessWidget {
  const AddPlayerItem({
    super.key,
    required this.selectedUsers,
    required this.index,
    required this.onPressed,
  });

  final List<UserInformation> selectedUsers;
  final int index;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('${(index + 1)}-'),
            const SizedBox(width: 5),
            Text(
              selectedUsers[index].displayName,
              style: Styles.normal16,
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}