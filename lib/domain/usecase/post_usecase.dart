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

  Future<Either<Failure, void>> createPost( String title, String content) async {
    return await repository.createPost(title,content);
  }
}
