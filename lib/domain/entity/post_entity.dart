import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class PostEntity {
  final int id;
  final String title;
  final String content;
  final String status;
  final String authorName;
  final DateTime createdAt;
  final List<CommentEntity> comments;

  PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.authorName,
    required this.createdAt,
    required this.comments,
  });
  PostEntity copyWith({
    int? id,
    String? title,
    String? content,
    String? status,
    String? authorName,
    DateTime? createdAt,
    List<CommentEntity>? comments,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
    );
  }
}
