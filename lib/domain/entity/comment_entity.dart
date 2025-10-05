class CommentEntity {
  final int id;
  final String content;
  final String commentStatus;
  final DateTime createdAt;
  final Author author;

  CommentEntity({
    required this.id,
    required this.content,
    required this.commentStatus,
    required this.createdAt,
    required this.author,
  });
}

class Author {
  final int id;
  final String username;

  Author({required this.id, required this.username});
}
