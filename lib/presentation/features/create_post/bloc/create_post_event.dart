import 'package:equatable/equatable.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPostEvent extends CreatePostEvent {
  final String title;
  final String content;

  const SubmitPostEvent({required this.title, required this.content});

  @override
  List<Object?> get props => [title, content];
}
