import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/features/leagues/presentation/views/widgets/event_info_body.dart';
import 'package:flutter/material.dart';

class EventInfoView extends StatelessWidget {
  const EventInfoView({super.key, required this.event});

  final League event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: EventInfoBody(event: event)),
                      const SizedBox(width: 20),
                      EventPicture(downloadUrl: event.downloadUrl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
