part of 'edit_event_bloc.dart';

abstract class EditEventState {}

final class EditEventInitial extends EditEventState {}

final class EditEventLoading extends EditEventState {}

final class EditEventSuccess extends EditEventState {
  final String msg;

  EditEventSuccess({required this.msg});
}

final class EditEventFailure extends EditEventState {
  final String err;

  EditEventFailure({required this.err});
}
