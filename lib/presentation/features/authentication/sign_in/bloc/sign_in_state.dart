part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  final bool isPasswordObscured;

  const SignInInitial({this.isPasswordObscured = true});

  @override
  List<Object?> get props => [isPasswordObscured];
}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final int uid;
  final String role;
  final String username;

  const SignInSuccess(this.uid, this.role, this.username);

  @override
  List<Object?> get props => [uid, role, username];
}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class SignInPasswordVisibilityChanged extends SignInState {
  final bool isPasswordObscured;

  const SignInPasswordVisibilityChanged(this.isPasswordObscured);

  @override
  List<Object?> get props => [isPasswordObscured];
}
