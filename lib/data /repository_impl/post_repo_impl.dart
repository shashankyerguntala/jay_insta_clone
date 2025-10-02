import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/remote_data_sources/post_data_source.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final result = await dataSource.getAllPosts();
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((m) => m as PostEntity).toList()),
    );
  }

  @override
  Future<Either<Failure, void>> createPost(String title, String content) async {
    final result = await dataSource.createPost(title, content);
    return result.fold((failure) => Left(failure), (model) => Right(null));
  }
}
