import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

class CommentDataSource {
  final DioClient dio;

  CommentDataSource({required this.dio});

  Future<Either<Failure, String>> sendComment(
    int userId,
    int postId,
    String content,
  ) async {
    final response = await dio.postRequest(
      ApiConstants.sendComment(),
      data: {"userId": userId, "postId": postId, "content": content},
    );

    return response.fold(
      (fail) => left(Failure('Error while sending the comment')),
      (data) => right("Comment sent for Approval "),
    );
  }
}
