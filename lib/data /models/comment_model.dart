import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.content,
    required super.status,
    required super.authorName,
    required super.postId,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? "",
      content: json['content'] ?? "",
      status: json['status'] ?? "",
      authorName: json['authorName'] ?? "",
      postId: json['postId'] ?? "",
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'status': status,
      'authorName': authorName,
      'postId': postId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
