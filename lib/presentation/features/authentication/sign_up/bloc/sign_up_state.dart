import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String userId;
  const SignUpSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SignUpFailure extends SignUpState {
  final String message;
  const SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}
