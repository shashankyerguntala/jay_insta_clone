import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentSending extends CommentState {}

class CommentSentSuccess extends CommentState {}

class CommentSentFailure extends CommentState {
  final String message;

  const CommentSentFailure(this.message);

  @override
  List<Object?> get props => [message];
}
