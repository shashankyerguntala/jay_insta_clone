import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(onSignUpSubmitted);
  }

  Future<void> onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {



    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
