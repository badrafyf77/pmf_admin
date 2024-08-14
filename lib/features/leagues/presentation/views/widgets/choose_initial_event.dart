// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pmf_admin/features/leagues/data/model/league_model.dart';
import 'package:pmf_admin/core/utils/customs/drop_down_field.dart';
import 'package:pmf_admin/core/utils/styles.dart';
import 'package:pmf_admin/features/leagues/presentation/manager/set%20initial%20event%20bloc/set_initial_event_bloc.dart';

class ChooseInitialEvent extends StatefulWidget {
  const ChooseInitialEvent({
    super.key,
    required this.eventsList,
    required this.initialEvent,
  });

  final List<League> eventsList;
  final League initialEvent;

  @override
  State<ChooseInitialEvent> createState() => _ChooseInitialEventState();
}

class _ChooseInitialEventState extends State<ChooseInitialEvent> {
  List<String> items = [];
  @override
  void initState() {
    super.initState();
    getEventsTitle();
  }

  getEventsTitle() {
    for (var element in widget.eventsList) {
      items.add(element.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Choisir l\'événement initial',
          style: Styles.normal15,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 42.5,
          width: 300,
          child: (items.isNotEmpty)
              ? MyDropDownField(
                  initialValue: widget.initialEvent.title,
                  onChanged: (value) {
                    if (value != null) {
                      int index = items.indexOf(value);
                      BlocProvider.of<SetInitialEventBloc>(context).add(
                        SetInitialEvent(
                          event: widget.eventsList[index],
                        ),
                      );
                    }
                  },
                  items: items,
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
