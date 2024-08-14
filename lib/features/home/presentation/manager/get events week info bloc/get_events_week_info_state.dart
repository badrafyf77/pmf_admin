part of 'get_events_week_info_bloc.dart';

sealed class GetEventsWeekInfoState {}

final class GetEventsWeekInfoInitial extends GetEventsWeekInfoState {}

final class GetEventsWeekInfoLoading extends GetEventsWeekInfoState {}

final class GetEventsWeekInfoSuccess extends GetEventsWeekInfoState {
  final EventsWeekInfo eventsWeekInfo;

  GetEventsWeekInfoSuccess({required this.eventsWeekInfo});
}

final class GetEventsWeekInfoFailure extends GetEventsWeekInfoState {
  final String err;

  GetEventsWeekInfoFailure({required this.err});
}
