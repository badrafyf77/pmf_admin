import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmf_admin/features/users/data/models/users_model.dart';
import 'package:pmf_admin/features/users/data/repo/users_repo.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  final UsersRepo _usersRepo;
  GetUsersCubit(this._usersRepo) : super(GetUsersInitial());

  Future<void> getUsers() async {
    emit(GetUsersLaoding());
    var result = await _usersRepo.getUsers();
    result.fold((left) {
      emit(GetUsersFailure(err: left.errMessage));
    }, (right) {
      emit(GetUsersSuccess(usersList: right));
    });
  }
}
