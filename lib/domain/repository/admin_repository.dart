import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';


abstract class AdminRepository {
  Future<Either<Failure, List<ModeratorRequestModel>>> getModeratorRequests();
  Future<Either<Failure, bool>> approveModeratorRequest(int requestId, int adminId);
  Future<Either<Failure, bool>> rejectModeratorRequest(int requestId, int adminId);
}
