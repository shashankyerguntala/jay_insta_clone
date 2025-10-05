import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.content,
    required super.commentStatus,
    required super.createdAt,
    required super.author,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      content: json['content'] as String,
      commentStatus: json['commentStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      author: AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "commentStatus": commentStatus,
      "createdAt": createdAt.toIso8601String(),
      "author": (author as AuthorModel).toJson(),
    };
  }
}

class AuthorModel extends Author {
  AuthorModel({required super.id, required super.username});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "username": username};
  }
}
