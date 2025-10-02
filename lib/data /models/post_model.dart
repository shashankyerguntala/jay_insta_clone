import 'package:jay_insta_clone/domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.author,
    required super.createdAt,
    required super.status,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,

      createdAt: DateTime.parse(json['created_at'] as String),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "author": author,
      "created_at": createdAt.toIso8601String(),
      "status": status,
    };
  }

  PostEntity toEntity() => PostEntity(
    id: id,
    title: title,

    content: content,
    author: author,
    createdAt: createdAt,
    status: status,
  );
}
