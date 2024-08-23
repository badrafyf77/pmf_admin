import 'package:flutter/material.dart';
import 'package:pmf_admin/features/players/presentation/views/widgets/player_list_item.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Column(
              children: [
                PlayerItem(),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
