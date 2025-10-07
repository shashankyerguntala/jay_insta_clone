import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'comment_model.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.status,
    required super.authorName,
    required super.createdAt,
    required super.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] ?? "",
      content: json['content'] ?? "",
      status: json['status'] ?? "",
      authorName: json['authorName'] ?? "",
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      comments: (json['approvedComments'] as List<dynamic>? ?? [])
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'status': status,
      'authorName': authorName,
      'createdAt': createdAt.toIso8601String(),
      'approvedComments': comments
          .map((comment) => (comment as CommentModel).toJson())
          .toList(),
    };
  }
}

