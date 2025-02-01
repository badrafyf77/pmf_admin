part of 'get_home_info_bloc.dart';

sealed class GetHomeInfoState {}

final class GetHomeInfoInitial extends GetHomeInfoState {}

final class GetHomeInfoLoading extends GetHomeInfoState {}

final class GetHomeInfoSuccess extends GetHomeInfoState {
  final HomeInfo homeInfo;

  GetHomeInfoSuccess({required this.homeInfo});
}

final class GetHomeInfoFailure extends GetHomeInfoState {
  final String err;

  GetHomeInfoFailure({required this.err});
}
