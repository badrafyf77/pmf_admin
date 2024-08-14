part of 'get_events_week_info_bloc.dart';

sealed class GetEventsWeekInfoEvent {}

class GetEventsWeekInfo extends GetEventsWeekInfoEvent {
  final DateTime date;

  GetEventsWeekInfo({required this.date});
}
