part of 'add_event_bloc.dart';

@immutable
abstract class AddEventState {}

final class AddEventInitial extends AddEventState {}

final class AddEventLaoding extends AddEventState {}

final class AddEventSuccess extends AddEventState {
  final String msg;

  AddEventSuccess({required this.msg});
}

final class AddEventFailure extends AddEventState {
  final String err;

  AddEventFailure({required this.err});
}
