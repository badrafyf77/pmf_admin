part of 'get_home_info_bloc.dart';

sealed class GetHomeInfoEvent {}

class GetHomeInfo extends GetHomeInfoEvent {
  final DateTime date;

  GetHomeInfo({required this.date});
}
