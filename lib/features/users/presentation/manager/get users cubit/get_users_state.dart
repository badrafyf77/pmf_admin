part of 'get_users_cubit.dart';

sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersLaoding extends GetUsersState {}

final class GetUsersSuccess extends GetUsersState {
  final List<UserInformation> usersList;

  GetUsersSuccess({required this.usersList});
}

final class GetUsersFailure extends GetUsersState {
  final String err;

  GetUsersFailure({required this.err});
}
