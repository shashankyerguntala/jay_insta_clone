import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PostEntity> posts;

  const HomeLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

