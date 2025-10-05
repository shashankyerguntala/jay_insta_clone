import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aadd_admin_event.dart';
part 'aadd_admin_state.dart';

class AaddAdminBloc extends Bloc<AaddAdminEvent, AaddAdminState> {
  AaddAdminBloc() : super(AaddAdminInitial()) {
    on<AaddAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
