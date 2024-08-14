part of 'set_initial_event_bloc.dart';

@immutable
abstract class SetInitialEventEvent {}

class SetInitialEvent extends SetInitialEventEvent {
  final League event;

  SetInitialEvent({required this.event});
}
