import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchPostsEvent extends HomeEvent {}

class FlagPostEvent extends HomeEvent {
  final int postId;

  const FlagPostEvent({required this.postId});
}
