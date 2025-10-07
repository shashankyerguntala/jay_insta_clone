import 'package:jay_insta_clone/domain/entity/moderator_request_entity.dart';

class ModeratorRequestModel extends ModeratorRequestEntity {
  ModeratorRequestModel({
    required super.id,
    required super.status,
    required super.username,
    required super.requestedAt,
    required super.reviewedBy,
  });

  factory ModeratorRequestModel.fromJson(Map<String, dynamic> json) {
    return ModeratorRequestModel(
      id: json['id'],
      status: json['status'],
      username: json['username'],
      requestedAt: DateTime.parse(json['requestedAt']),
      reviewedBy: json['reviewedBy'],
    );
  }
}
