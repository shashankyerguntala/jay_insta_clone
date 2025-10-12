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

class EditPostEvent extends CreatePostEvent {
  final int postId;
  final String title;
  final String content;

  const EditPostEvent({
    required this.postId,
    required this.title,
    required this.content,
  });

  @override
  List<Object?> get props => [title, content];
}
