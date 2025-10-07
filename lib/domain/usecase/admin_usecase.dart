import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';
import 'package:jay_insta_clone/domain/repository/admin_repository.dart';

class AdminUseCase {
  final AdminRepository repository;

  AdminUseCase({required this.repository});

  Future<Either<Failure, List<ModeratorRequestModel>>> getModeratorRequests() {
    return repository.getModeratorRequests();
  }

  Future<Either<Failure, bool>> approveModeratorRequest(
    int requestId,
    int adminId,
  ) {
    return repository.approveModeratorRequest(requestId, adminId);
  }

  Future<Either<Failure, bool>> rejectModeratorRequest(
    int requestId,
    int adminId,
  ) {
    return repository.rejectModeratorRequest(requestId, adminId);
  }
}
