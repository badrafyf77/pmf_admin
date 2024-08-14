import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/league_item.dart';
import 'package:flutter/material.dart';

class LeaguesListViewBuilder extends StatelessWidget {
  const LeaguesListViewBuilder({
    super.key,
    required this.itemsList,
  });

  final List<League> itemsList;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              LeagueItem(
                league: itemsList[index],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
