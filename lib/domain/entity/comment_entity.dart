class CommentEntity {
  final int id;
  final String content;
  final String status;
  final String authorName;
  final int postId;
  final DateTime createdAt;

  CommentEntity({
    required this.id,
    required this.content,
    required this.status,
    required this.authorName,
    required this.postId,
    required this.createdAt,
  });
  CommentEntity copyWith({
    int? id,
    String? content,
    String? status,
    String? authorName,
    int? postId,
    DateTime? createdAt,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      status: status ?? this.status,
      authorName: authorName ?? this.authorName,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
