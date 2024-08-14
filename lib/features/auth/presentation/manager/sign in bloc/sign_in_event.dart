part of 'sign_in_bloc.dart';

sealed class SignInEvent {}

class SignIn extends SignInEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});
}
