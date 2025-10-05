part of 'aadd_admin_bloc.dart';

sealed class AaddAdminState extends Equatable {
  const AaddAdminState();
  
  @override
  List<Object> get props => [];
}

final class AaddAdminInitial extends AaddAdminState {}
