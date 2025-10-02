import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';

class PostDataSource {
  final DioClient dioClient;

  PostDataSource(this.dioClient);

  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    final response = await dioClient.getRequest(ApiConstants.getPosts);
    return response.fold((failure) => Left(failure), (data) {
      final list = (data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
      return Right(list);
    });
  }

  Future<Either<Failure, void>> createPost(String title, String content) async {
    final response = await dioClient.postRequest(
      ApiConstants.createPost,
      data: {"title": title, "content": content},
    );
    return response.fold((failure) => Left(failure), (data) => Right(null));
  }

  Future<Either<Failure, List<PostModel>>> getUserPosts(String userId) async {
    final response = await dioClient.getRequest(ApiConstants.userPosts(userId));
    return response.fold((left) => Left(left), (data) {
      final posts = (data as List).map((e) => PostModel.fromJson(e)).toList();
      return Right(posts);
    });
  }
}
