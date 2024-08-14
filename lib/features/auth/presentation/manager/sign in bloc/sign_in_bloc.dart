import 'package:pmf_admin/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepo _authRepo;
  SignInBloc(this._authRepo) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is SignIn) {
        emit(SignInLoading());
        var result = await _authRepo.signIn(event.email, event.password);
        result.fold((left) {
          emit(SignInFailure(err: left.errMessage));
        }, (right) {
          emit(SignInSuccess());
        });
      }
    });
  }
}
