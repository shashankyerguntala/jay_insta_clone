import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/core%20/shared_prefs/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/auth_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthUsecase authUsecase;
  bool isPasswordObscured = true;
  int? uid;
  String? role;
  SignInBloc({required this.authUsecase}) : super(const SignInInitial()) {
    on<ShowPasswordEvent>((event, emit) {
      isPasswordObscured = !isPasswordObscured;
      emit(SignInPasswordVisibilityChanged(isPasswordObscured));
    });

    on<SignInRequested>((event, emit) async {
      emit(SignInLoading());
      final result = await authUsecase.login(
        email: event.email,
        password: event.password,
      );

       result.fold(
        (failure)  {
          emit(SignInFailure(failure.message));
        },
        (user) async {
          await AuthLocalStorage.saveUid(user.id);
          await AuthLocalStorage.saveRole(user.role);

          final uid = user.id;
          final role = await AuthLocalStorage.getRole();/////////////////////CHECK

          emit(SignInSuccess(uid, role!, user.username));
        },
      );
    });
  }
}
