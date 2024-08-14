part of 'set_initial_event_bloc.dart';

@immutable
abstract class SetInitialEventState {}

final class SetInitialEventInitial extends SetInitialEventState {}

final class SetInitialEventLaoding extends SetInitialEventState {}

final class SetInitialEventSuccess extends SetInitialEventState {
  final String msg;

  SetInitialEventSuccess({required this.msg});
}

final class SetInitialEventFailure extends SetInitialEventState {
  final String err;

  SetInitialEventFailure({required this.err});
}
