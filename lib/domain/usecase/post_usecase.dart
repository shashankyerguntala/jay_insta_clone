import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';

class PostUseCase {
  final PostRepository repository;

  PostUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    return await repository.getAllPosts();
  }

  Future<Either<Failure, String>> createPost(
    int uid,
    String title,
    String content,
  ) async {
    return await repository.createPost(uid, title, content);
  }

  Future<Either<Failure, List<PostEntity>>> getUserPosts(String userId) async {
    return await repository.getUserPosts(userId);
  }
}
