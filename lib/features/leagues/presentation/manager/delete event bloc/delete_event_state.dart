part of 'delete_event_bloc.dart';

sealed class DeleteEventState {}

final class DeleteEventInitial extends DeleteEventState {}

final class DeleteEventLoading extends DeleteEventState {}

final class DeleteEventSuccess extends DeleteEventState {
  final String msg;

  DeleteEventSuccess({required this.msg});
}

final class DeleteEventFailure extends DeleteEventState {
  final String err;

  DeleteEventFailure({required this.err});
}
